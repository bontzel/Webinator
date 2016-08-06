var Grid = ReactBootstrap.Grid;
var Row = ReactBootstrap.Row;
var Col = ReactBootstrap.Col;
var Collapse = ReactBootstrap.Collapse;
var Well = ReactBootstrap.Well;
var PageHeader = ReactBootstrap.PageHeader;
var Label = ReactBootstrap.Label;
var Table = ReactBootstrap.Table;


var GroupPictureAndReview = React.createClass({

  getInitialState: function() {
    return {
      preview: false,
      previewSource: "",
    };
  },

  onImageClick: function(imageSource) {

    this.props.setImage(imageSource);

    this.setState({
      preview: true,
      previewSource: imageSource,
    });
  },



  render: function() {

    var twoRows = false;
    var tagsNodes1;
    var tagsNodes2;

    if (this.props.categories.length > 6) {
      twoRows = true;

      tagsNodes2 = this.props.categories.slice(6, 11).map(function(item, index) {

        return(
          <td key = {index}> <h4> <Label> {item.name} </Label> </h4> </td>
        );

      });
    }

    tagsNodes1 = this.props.categories.slice(0, 5).map(function(item, index) {

      return(
        <td key = {index}> <h4> <Label> {item.name} </Label> </h4> </td>
      );

    });

    return(
      <Grid fluid={true}>
        <Row>
          <Col md={3}></Col>
          <Col md={2}>
            <GroupIcon source = "/images/celebrity_icon.png" selectImage = {this.onImageClick}  />
          </Col>
          <Col md={2}>
            <GroupIcon source ="/images/coding_icon.png" selectImage = {this.onImageClick} />
          </Col>
          <Col md={2}>
            <GroupIcon source = "/images/economics_icon.png" selectImage = {this.onImageClick}  />
          </Col>
          <Col md={3}></Col>
        </Row>
        <br></br>
        <Row>
          <Col md={3}></Col>
          <Col md={2}>
            <GroupIcon source = "/images/music_icon.jpg" selectImage = {this.onImageClick}  />
          </Col>
          <Col md={2}>
            <GroupIcon source = "/images/politics_icon.jpg" selectImage = {this.onImageClick}  />
          </Col>
          <Col md={2}>
            <GroupIcon source = "/images/tech_icon.png" selectImage = {this.onImageClick}  />
          </Col>
          <Col md={3}></Col>
        </Row>
        <br></br>
        <Row>
          <Col md={12}>
            <Collapse in = {this.state.preview}>
              <div>
                <Row>
                  <Col md = {5}></Col>
                  <Col md = {4}>
                    <PageHeader>
                      Group Preview
                    </PageHeader>
                  </Col>
                  <Col md = {3}></Col>
                </Row>
                <Row>
                  <Col md = {2}></Col>
                  <Col md = {2}>
                    <Image src = {this.state.previewSource} responsive/>
                  </Col>
                  <Col md = {7}>
                    <PageHeader>
                      {this.props.title}
                    </PageHeader>
                  </Col>
                </Row>
                <Row>
                  <Col md = {2}></Col>
                  <Col md = {10}>
                    <h4> {this.props.description} </h4>
                  </Col>
                </Row>
                <Row>
                  <Col md = {2}></Col>
                  <Col md = {10}>
                    <Row>
                      <Table responsive>
                        <tbody>
                          <tr>
                            {tagsNodes1}
                          </tr>
                          <tr>
                            {tagsNodes2}
                          </tr>
                        </tbody>
                      </Table>
                    </Row>
                  </Col>
                </Row>
              </div>
            </Collapse>
          </Col>
        </Row>
        <Row>
          <Col md = {2}></Col>
          <Col md = {6}>
            <Button bsStyle = "primary" onClick = {this.props.onCancel} > Back </Button>
          </Col>
          <Col md = {4}>
            <Button bsStyle = "primary" onClick = {this.props.onCreate}> Create Group </Button>
          </Col>
        </Row>
      </Grid>
    );
  },
});
