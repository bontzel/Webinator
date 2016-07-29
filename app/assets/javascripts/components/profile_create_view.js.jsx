var ProfileCreateView = React.createClass({
  
  
	getInitialState: function() {
		return {
			firstName: "",
			lastName: "",
			selectedCategories: [],
			categories: [],
			loading: false,
		};
	},
	
	getTitleValidationState() {
    const length = this.state.firstName.length;
    if (length == 0) return 'error';
    else return 'success'
  },
  
  getDescriptionValidationState() {
    const length = this.state.lastName.length;
    if (length == 0) return 'error';
    else return 'success'
  },
	
	handleFirstName: function(e) {
    this.setState({ firstName: e.target.value });
  },
  
  handleLastName: function(e) {
    this.setState({ lastName: e.target.value });
  },
	
	handleSubmit: function() {
		var paramsData = {
      first_name: this.state.firstName, 
      last_name: this.state.lastName,
      categories: this.getSelectedCategories(),
    };
    
    var params = JSON.stringify(paramsData);
		
		console.dir(params);
		var selfObj = this;
		
		$.ajax({
      type: 'POST',
      url: '/users/' + this.props.user_id + '/profiles',
			contentType: 'application/json',
			dataType: 'json',
			data: params,
      beforeSend: function() {
        selfObj.setState({
					loading: true
				});
      },
      success:function(data) {
        window.location.replace(data.redirect_url);
      },
      error:function() {
        // failed request; give feedback to user
				alert("Request Failed. Please try again!");
				selfObj.setState({
					loading: false
				});
      }
    });
	},
	
	setSelectedCategories: function(newCategories) {
		this.setState({
			selectedCategories: newCategories,
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
	
	setCategories: function(newCategories) {
		this.setState({
			categories: newCategories,
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
	
	
  render: function() {
		
		if(this.state.loading) {
			return (
				<div>
					<h2> Loading... </h2>
				</div>
			);
		} else {
			return(
				<form>
					<h3> General Information </h3>
					<FormGroup
						controlId="firstNameControl"
						validationState={this.getTitleValidationState()}
					>
						<FormControl
							type="text"
							value={this.state.firstName}
							placeholder="First Name"
							onChange={this.handleFirstName}
						/>
						<FormControl.Feedback />
					</FormGroup>

					<FormGroup
						controlId="lastNameControl"
						validationState={this.getDescriptionValidationState()}
					>
						<FormControl type="text" 
												 placeholder="Last Name"
												 value={this.state.lastName}
												 onChange={this.handleLastName}
												 />
						<FormControl.Feedback />
						<HelpBlock>Fields must no be empty</HelpBlock>
					</FormGroup>

					<h3>Interests</h3>
					<br></br>
					<ProfileCategoriesChoice selectCategory = {this.selectCategory} updateCategories = {this.setCategories}/>
					<Row>
						<Col md = {10}></Col>
						<Col md = {2}>
							<Button bsStyle = "primary" onClick = {this.handleSubmit}> Create </Button>
						</Col>
					</Row>
				</form>
			);
		}
  }
});