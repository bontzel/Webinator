var Button = ReactBootstrap.Button;
var Grid = ReactBootstrap.Grid;
var Row = ReactBootstrap.Row;
var Col = ReactBootstrap.Col;
var Panel = ReactBootstrap.Panel;
var Input = ReactBootstrap.Input;
var ButtonInput = ReactBootstrap.ButtonInput;


var CommentLikeButton = React.createClass({
  getInitialState: function() {
    return {
      liked: this.props.liked
    };
  },

  render: function() {
    console.log(this.props.liked);
    if(this.props.liked)
      return(
        <Row>
          <Col md={1}>
            <Button bsStyle="link" className="comment_like" > Liked! </Button>
          </Col>
          <Col md={11}></Col>
        </Row>
      );
    else
      return(
        <Row>
          <Col md={1}>
            <Button bsStyle="link" className="comment_like" onClick = {this.props.handleLikeClick}> Like </Button>
          </Col>
          <Col md={11}></Col>
        </Row>
      );
  },
});

var Comment = React.createClass({

  getInitialState: function() {
    return {
      liked: false,
    };
  },

  componentDidMount: function() {
    this.checkIfLiked();
  },

  handleLikeClick: function(e) {
      console.log(this.props.comment.id);
    $.ajax({
      type: 'POST',
      url: "/comments/like",
      dataType: 'json',
      data: this.props.comment,
      success: function (data) {
        console.log("Success!");
        console.log(data);
        e.target.innerHTML = "Liked!";
        this.setState({
          liked: true
        });
      }.bind(this),
      error: function (xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },

  checkIfLiked: function() {
    //console.log("comment id -> " + this.props.comment.id);
    var json = new Object();
    json.id = this.props.comment.id;

    console.log(json);
    $.ajax({
      type: "GET",
      url: "/comments/check_for_like",
      dataType: 'json',
      contentType: 'application/json',
      data: json,
      success: function(isLiked) {
        console.log("succes: " + isLiked);
        if(isLiked) {
          this.setState({
            liked: true,
          });
        }
      }.bind(this),
      error: function (xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },

  render: function() {
    console.log("liked -> " + this.state.liked);
    const CommentHeading = (
          <Row>
            <Col md={1}>
              <img src={this.props.comment.user.profile.avatar.avatar.url}  width="25" height="25"></img>
            </Col>
            <Col md={10}>
              {this.props.comment.user.profile.first_name} said:
            </Col>
          </Row>
        );

    return (
      <Row>
        <Col md={1}></Col>
        <Col md={10}>
          <Panel header= {CommentHeading} >
            <Row>
              <Col md={12}>
              {this.props.comment.text}
            </Col>
            </Row>
            <CommentLikeButton liked = {this.state.liked}
                                handleLikeClick = {this.handleLikeClick}
                                />
          </Panel>
        </Col>
        <Col md={1}></Col>
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
          <Row>
            <Col md={1}></Col>
            <Col md={10}>
              <Input type="textarea" value = {value} onChange={this.handleChange}></Input>
            </Col>
            <Col md={1}></Col>
          </Row>
          <Row>
            <Col md={4}></Col>
            <Col md={4}>
              <ButtonInput type="submit" value="Post Comment!"></ButtonInput>
            </Col>
            <Col md={4}></Col>
          </Row>
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
        <CommentList comments = {this.state.comments} />
        <CommentForm url = {this.state.url} onPostSuccess = {this.addComment}/>
      </div>
    );
  }
});
