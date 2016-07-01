var ButtonGroup = ReactBootstrap.ButtonGroup;
var Button = ReactBootstrap.Button;
var ButtonToolbar = ReactBootstrap.ButtonToolbar;
var Grid = ReactBootstrap.Grid;
var Row = ReactBootstrap.Row;
var Col = ReactBootstrap.Col;

var GroupCategoryChoice = React.createClass({
  
  selectCategory: function(e) {
    
  },
  
  render: function() {
      return(
        <Grid>
          <Row>
            <Col md = {4}></Col>
            <Col md = {8}>
              <h2> Choose categories </h2>
              <ButtonToolbar>
                <Button bsSize="large">Music</Button>
                <Button bsSize="large">Technology</Button>
                <Button bsSize="large">News</Button>
                <Button bsSize="large">Economy</Button>
              </ButtonToolbar>
              <br></br>
              <ButtonToolbar>
                <Button bsSize="large">Biology</Button>
                <Button bsSize="large">Politics</Button>
                <Button bsSize="large">Media</Button>
                <Button bsSize="large">Celebrities</Button>
              </ButtonToolbar>
              <br></br>
              <ButtonToolbar>
                <Button bsSize="large">Bussiness</Button>
                <Button bsSize="large">Gaming</Button>
                <Button bsSize="large">Art</Button>
                <Button bsSize="large">Programming</Button>
              </ButtonToolbar>
              <br></br>
              <ButtonToolbar>
                <Button bsSize="large">Consoles</Button>
                <Button bsSize="large">Entertainments</Button>
                <Button bsSize="large">Sports</Button>
                <Button bsSize="large">Environment</Button>
              </ButtonToolbar>
            </Col>
          </Row>
        </Grid>
      );
  }
});