var Button = ReactBootstrap.Button;
var Grid = ReactBootstrap.Grid;
var Row = ReactBootstrap.Row;
var Col = ReactBootstrap.Col;
var Panel = ReactBootstrap.Panel;
var FormControl = ReactBootstrap.FormControl;


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
      console.dir(this.props.comment);

      var likeButton = e.target;

    $.ajax({
      type: 'POST',
      url: "/comments/like",
      dataType: 'json',
      data: this.props.comment,
      success: function (data) {
        console.log("like result -> ")
        console.dir(data.success);
        if (data.success) {
          this.setState({
            liked: true
          });
        }
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

		console.log("user: ");
		console.dir(this.props.comment.user.profile);

    const CommentHeading = (
          <Row>
            <Col md={1}>
              <img src={this.props.comment.user.profile.avatar.url}  width="25" height="25"></img>
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
    var dataJSON = {
      "text" : this.state.comment.text,
    };

    var params = JSON.stringify(dataJSON);

    $.ajax({
      type: 'POST',
      url: this.props.url,
      dataType: 'json',
      contentType: 'application/json',
      data: params,
      success: function (data) {
        console.log("comment post response ->");
        console.dir(data);
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
				<Row>
					<Col md={1}></Col>
					<Col md={10}>
						<FormControl componentClass="textarea" value = {value} onChange={this.handleChange}></FormControl>
					</Col>
					<Col md={1}></Col>
				</Row>
				<br></br>
				<Row>
					<Col md={4}></Col>
					<Col md={4}>
						<Button bsStyle="primary" onClick = {this.handleSubmit}> Post Comment! </Button>
					</Col>
					<Col md={4}></Col>
				</Row>
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
           "/comments",
      intervalID: null,
    };
  },

  addComment: function(comment) {

    this.state.comments.push(comment);
    this.setState(
      {comments:this.state.comments}
    );
  },

  componentDidMount: function() {
    this.loadCommentsFromServer();
    this.setState({
      intervalID: setInterval(this.loadCommentsFromServer, 10000),
    });
  },

  componentWillUnmount: function() {
    clearInterval(this.state.intervalID);
  },

  loadCommentsFromServer: function () {
    var thisObj = this;

    $.ajax({
      url: this.state.url,
      dataType: 'json',
      success: function (data) {
				console.log("Received comments:");
				console.dir(data);

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
