var Grid = ReactBootstrap.Grid;
var Row = ReactBootstrap.Row;
var Col = ReactBootstrap.Col;
var Button = ReactBootstrap.Button;
var FormGroup = ReactBootstrap.FormGroup;
var ControlLabel = ReactBootstrap.ControlLabel;
var FormControl = ReactBootstrap.FormControl;
var HelpBlock = ReactBootstrap.HelpBlock;

var GroupTitleAndDescView = React.createClass({

  getInitialState() {
    return {
      title: "",
      description: ""
    };
  },

  componentDidMount() {
    this.setState({
      title: this.props.title,
      description: this.props.description,
    });
  },

  handleTitle: function(e) {
    this.setState({ title: e.target.value });
    this.props.onTitleEdit(e.target.value);
  },

  handleDesc: function(e) {
    this.setState({ description: e.target.value });
    this.props.onDescriptionEdit(e.target.value);
  },

  getTitleValidationState() {
    const length = this.state.title.length;
    if (length == 0) return 'error';
    else return 'success'
  },

  getDescriptionValidationState() {
    const length = this.state.description.length;
    if (length == 0) return 'error';
    else return 'success'
  },

  onNextClicked: function() {
    if (this.getTitleValidationState() === 'success' &&
        this.getDescriptionValidationState() === 'success') {

      this.props.onNextPressed();
      return true;
    }

    return false;
  },

  render: function() {
    return(
      <Grid fluid={true}>
        <Row>
          <Col md={2}></Col>
          <Col md={8}>
            <form>
              <FormGroup
                controlId="formBasicText1"
                validationState={this.getTitleValidationState()}
              >
                <ControlLabel>Enter group title</ControlLabel>
                <FormControl
                  type="text"
                  value={this.state.title}
                  placeholder="Enter title"
                  onChange={this.handleTitle}
                />
                <FormControl.Feedback />
              </FormGroup>

              <FormGroup
                controlId="formBasicText2"
                validationState={this.getDescriptionValidationState()}
              >
                <ControlLabel>Enter group description</ControlLabel>
                <FormControl componentClass="textarea"
                             placeholder="Description"
                             value={this.state.description}
                             onChange={this.handleDesc}
                             />
                <FormControl.Feedback />
              </FormGroup>

              <HelpBlock>Fields must no be empty</HelpBlock>

              <Row>
                <Col md = {10}></Col>
                <Col md = {2}>
                  <Button bsStyle = "primary"
                          bsSize = "large"
                          onClick = {this.onNextClicked}> Next </Button>
                </Col>
              </Row>
            </form>

          </Col>
          <Col md={2}></Col>
        </Row>
      </Grid>
    );
  }

});
