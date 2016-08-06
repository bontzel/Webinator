var ButtonGroup = ReactBootstrap.ButtonGroup;
var Button = ReactBootstrap.Button;
var ButtonToolbar = ReactBootstrap.ButtonToolbar;
var Grid = ReactBootstrap.Grid;
var Row = ReactBootstrap.Row;
var Col = ReactBootstrap.Col;
var Fade = ReactBootstrap.Fade;

var GroupCategoryChoice = React.createClass({

  getInitialState() {
    return {
      selectedCategories: [],
      open: false,

    };
  },

  componentDidMount: function() {
    console.log("yep");

    this.setState({
        open: true,
    });
  },

  render: function() {

    if(!this.props.ready) {
      return (
        <Grid fluid = {true}>
          <Row>
            <Col md={12}>
              <h2> Loading... </h2>
            </Col>
          </Row>
        </Grid>
      );
    }

    var catSelectFun = this.props.onCategorySelect;
    var tagNodesArray = [];

    for (i = 0; i < this.props.categories.length; i = i + 4) {
      var tagNode = this.props.categories.slice(i, i + 4).map(function (tag) {
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
      <Grid fluid={true} >
          <Row>
            <Col md = {3}></Col>
            <Col md = {8}>
              <h2> Choose categories </h2>

              {tagsPool}

            </Col>
            <Col md = {1}></Col>
          </Row>
          <Row>
            <Col md = {4}></Col>
            <Col md = {4}>
              <Button bsStyle = "primary" onClick = {this.props.onCancel} > Back </Button>
            </Col>
            <Col md = {4}>
              <Button bsStyle = "primary" onClick = {this.props.onCategoryDone}> Next </Button>
            </Col>
          </Row>
      </Grid>
    );
  },
});
