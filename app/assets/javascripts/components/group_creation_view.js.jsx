var GroupCreationView = React.createClass({
  
  propTypes: {
    title: React.PropTypes.string,
    description: React.PropTypes.string,
  },
  
   getInitialState: function() {
    return {
      title: "",
      description: "",
      stage: 0
    };
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
   
  render: function() {
  
    if (this.state.stage == 0) {
      return (
        <div>
          <GroupTitleAndDescView onTitleEdit = {this.setTitle}
                                 onDescriptionEdit =  {this.setDescription}
                                 onNextPressed = {this.onDescriptionDone}
            />
        </div>
      );
    } else if (this.state.stage == 1) {
      return (
        <GroupCategoryChoice/>
      );
    }
  }
  
});