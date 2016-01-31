var ButtonToolbar = ReactBootstrap.Button;
var Grid = ReactBootstrap.Grid;
var Row = ReactBootstrap.Row;
var Col = ReactBootstrap.Col;
var Panel = ReactBootstrap.Panel;



var Comment = React.createClass({

  render: function() {
    var CommentHeading = React.createClass({
      render: function(){
        return(
          <Row>
            <Col md={1}>
              <img src={this.props.comment.user.profile.avatar.avatar.url}  width="25" height="25"></img>
            </Col>
            <Col md={11}>
              {this.props.comment.user.profile.first_name} said:
            </Col>
          </Row>
        );
      },
    });

    console.log(this.props.comment.user.profile.avatar.avatar);
    return (
      <Row>
        <Col md={1}></Col>
        <Col md={10}>
          <Panel heading={CommentHeading}>
            {this.props.comment.text}
          </Panel>
        </Col>
      </Row>
    );
  }
});

var CommentList = React.createClass({

  render: function () {
    var commentNodes = this.props.comments.map(function (comment, index) {
      return (
        <Comment comment = {comment} key={index} />
        );
    });

    return (
      <div className="commentList">
        {commentNodes}
      </div>
      );
  }
});

var CommentForm = React.createClass({
  propTypes: {
    url: React.PropTypes.string
  },

  getInitialState: function() {
    return {
      comment: {"text":""},
    };
  },

  handleChange: function(e) {
    this.setState(
      {comment: { "text" :e.target.value}}
    );
  },

  handleSubmit: function(e) {
    var text = JSON.stringify(this.state.comment);
    $.ajax({
      type: 'POST',
      url: this.props.url,
      dataType: 'json',
      data: this.state.comment,
      success: function (data) {
        this.props.onPostSuccess(data.comment);
        var comment = this.state.comment;
        comment.text = "";
        this.setState({
          comment: comment
        });
      }.bind(this),
      error: function (xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });

    e.preventDefault();
  },

  render: function() {
    var value = this.state.comment.text
    return (
      <div>
        <form method="post" remote="true" onSubmit={this.handleSubmit}>
          <textarea type="text" value = {value} onChange={this.handleChange} ></textarea>
          <button type="submit"> Post Comment </button>
      </form>
      </div>
    );
  }
});


var CommentsView = React.createClass({
  propTypes: {
    count: React.PropTypes.number,
    user_id: React.PropTypes.number,
    wall_id: React.PropTypes.number,
    post_id: React.PropTypes.number,
  },

  getInitialState: function() {
    return {
      comments: [],
      url: "/users/" + this.props.user_id +
           "/walls/" + this.props.wall_id +
           "/posts/" + this.props.post_id +
           "/comments"
    };
  },

  addComment: function(comment) {
    var newComments = this.state.comments
    newComments.push(comment);
    this.setState(
      {comments:newComments}
    );
  },

  componentDidMount: function() {
    this.loadCommentsFromServer();
  },

  loadCommentsFromServer: function () {
    $.ajax({
      url: this.state.url,
      dataType: 'json',
      success: function (data) {
        this.setState({comments: data.comments});
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
        <CommentForm url = {this.state.url} onPostSuccess = {this.addComment}/>
      </div>
    );
  }
});
