var ButtonGroup = ReactBootstrap.ButtonGroup;
var Button = ReactBootstrap.Button;
var ButtonToolbar = ReactBootstrap.ButtonToolbar;
var Grid = ReactBootstrap.Grid;
var Row = ReactBootstrap.Row;
var Col = ReactBootstrap.Col;
var Fade = ReactBootstrap.Fade;

var ProfileCategoriesChoice = React.createClass({

	getInitialState: function() {
		return {
			categories: [],
			categoriesPending: true,
			selectedCategories: [],
		};
	},



	componentDidMount: function() {
		this.getCategories();
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


        selfObj.props.updateCategories(selfObj.state.categories);
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

	render: function() {

		if(this.state.categoriesPending) {
			return (
				<div>
					<h2> Loading... </h2>
				</div>
			);
		}

		var catSelectFun = this.props.selectCategory;
		var tagNodesArray = [];

		for (i = 0; i < this.state.categories.length; i = i + 5) {
			var tagNode = this.state.categories.slice(i, i + 5).map(function (tag) {
				return(
					<GroupTagButton tag = {tag} categorySelection = {catSelectFun} key = {tag.id} />
				);
			});

			tagNodesArray.push(tagNode);
		}

		var tagsPool = tagNodesArray.map(function(tagNode, index) {
			return (
				<div key = {index}>
					<ButtonToolbar>
						{tagNode}
					</ButtonToolbar>
					<br></br>
				</div>
			);
		});

		return(
			<div>
					<Grid>
							<Row>
								<Col md = {0}></Col>
									<Col md = {11}>

										{tagsPool}

									</Col>
							</Row>
					</Grid>
			</div>
		);
	},
});
