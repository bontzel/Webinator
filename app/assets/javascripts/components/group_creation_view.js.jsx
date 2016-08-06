var GroupCreationView = React.createClass({

  propTypes: {
    title: React.PropTypes.string,
    description: React.PropTypes.string,
  },

   getInitialState: function() {
    return {
      title: "",
      description: "",
      stage: 0,
      categories: [],
      categoriesPending: true,
      icon: "",
    };
  },

  componentDidMount: function() {
    this.getCategories();
  },

  setTitle: function(text) {
    this.setState({
      title: text
    });
  },

  setDescription: function(text) {
    this.setState({
      description: text
    });
  },

  onDescriptionDone: function() {
    this.setState({
      stage: 1
    });
  },

  onCategoryChoiceCancel: function() {
    this.setState({
      stage: 0
    });
  },

  onIconAndReviewCancel: function() {
    this.setState({
      stage: 1
    });
  },

  selectCategory: function(category) {
    var categoryIndex = this.state.categories.indexOf(category);

    category.active = !category.active;

    this.state.categories.splice(categoryIndex, 1, category);

    this.setState({
      categories: this.state.categories,
      selectedCategories: this.state.selectedCategories,
    });

  },

  getCategories: function() {
    var selfObj = this;

    $.ajax({
      type: 'GET',
      url: '/tags',
      success:function(data) {
        // successful request; do something with the data
        data.forEach(function(item, index) {
          var cat = {
            id: item.id,
            name: item.name,
            active: false,
          };

          selfObj.state.categories.push(cat);
        });

        selfObj.setState({
          categories: selfObj.state.categories,
          categoriesPending: false,
        });


      },
      error:function() {
        // failed request; give feedback to user
        console.log("request cats failed")
      }
    });

  },

  getSelectedCategories: function() {
    var selCats = [];

    this.state.categories.forEach(function(item) {
      if(item.active) {
        selCats.push(item);
      }
    });

    return selCats;
  },

  setLoadingState: function() {
    this.setState({
      stage: 3,
    });
  },

  requestGroupCreation: function() {
    var selfObj = this;

    var paramsData = {
      title: selfObj.state.title,
      description: selfObj.state.description,
      user_id: selfObj.props.user_id,
      categories: selfObj.state.categories,
      imageSource: selfObj.state.icon,
    };

    var params = JSON.stringify(paramsData);

    $.ajax({
      type: 'POST',
      url: '/users/' + selfObj.props.user_id + "/groups",
      contentType: 'application/json; charset=utf-8',
      dataType: 'json',
      data: params,
      beforeSend: function() {
        selfObj.setLoadingState();
      },
      success: function(data) {
        window.location.replace(data.redirect_to);
      },
      error:function(){
        selfObj.categoryDone();
        alert("Request failed. Try again later!");
      }
    });

  },

  categoryDone: function() {
    this.setState({
      stage: 2
    });
  },

  setIcon: function(source) {
    this.setState({
      icon: source,
    });
  },

  render: function() {

    if (this.state.stage == 0) {
      return (
        <GroupTitleAndDescView onTitleEdit = {this.setTitle}
                               onDescriptionEdit =  {this.setDescription}
                               onNextPressed = {this.onDescriptionDone}
                               description = {this.state.description}
                               title = {this.state.title}

          />
      );
    } else if (this.state.stage == 1) {
      return (
        <GroupCategoryChoice
          categories = {this.state.categories}
          onCancel = {this.onCategoryChoiceCancel}
          onCategoryDone = {this.categoryDone}
          onCategorySelect = {this.selectCategory}
          ready = {!this.state.categoriesPending}
          key = "2"/>
      );
    } else if (this.state.stage == 2) {
      return (
          <GroupPictureAndReview description = {this.state.description}
            title = {this.state.title}
            categories = {this.getSelectedCategories()}
            onCancel = {this.onIconAndReviewCancel}
            onCreate = {this.requestGroupCreation}
            setImage = {this.setIcon}/>
        );
    } else if (this.state.stage == 3) {
      return(
        <Grid fluid={true}>
          <Row>
            <Col md = {12}>
              <h2 id = "loading" > Loading ... </h2>
            </Col>
          </Row>
        </Grid>
      );
    }
  }

});
