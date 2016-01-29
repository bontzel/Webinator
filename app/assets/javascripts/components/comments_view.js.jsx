var CommentList = React.createClass({
  render: function () {
    var commentNodes = this.props.comments.map(function (comment, index) {
      return (
        <Comment author={comment.author} comment={comment.comment} key={index} />
        );
    });

    return (
      <div className="commentList">
        {commentNodes}
      </div>
      );
  }
});


var CommentsView = React.createClass({
  propTypes: {
    count: React.PropTypes.number,
    url: React.PropTypes.string
  },

  getInitialState: function() {
    return {
      comments: []
    };
  },

  componentDidMount: function() {
    this.loadCommentsFromServer();
  },

  loadCommentsFromServer: function () {
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      success: function (comments) {
        this.setState({comments: comments});
      }.bind(this),
      error: function (xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },

  render: function() {
    return (
      <div>
        <div>Count: {this.props.count}</div>
        <h3> Comments: </h3>
        <CommentList comments = {this.state.comments} />
      </div>
    );
  }
});
