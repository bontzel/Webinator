var Image = ReactBootstrap.Image;

var GroupIcon = React.createClass({
  getInitialState: function() {
    return {
      selected: false,
    };
  },
  
  handleClick: function() {
    this.props.selectImage(this.props.source);
  },
  
  render: function() {
    
    return(
      <Image src = {this.props.source} onClick = {this.handleClick} responsive />
    );
    
  },
  
});