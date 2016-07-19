var Button = ReactBootstrap.Button;

var GroupTagButton = React.createClass({
  
  getInitialState: function() {
    return {
      stage: 1,
    };
  },
  
  handleClick: function(e) {
    this.props.categorySelection(this.props.tag);
  }, 
  
  render: function() {
    return(
      <Button bsSize="large" onClick = {this.handleClick} active = {this.props.tag.active}> {this.props.tag.name} </Button>
    );
  }
});