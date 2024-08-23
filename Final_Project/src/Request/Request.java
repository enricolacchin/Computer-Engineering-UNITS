package Request;

public class Request {
  private final RequestType type;
  private final String content;

  public Request(RequestType type, String content) {
    this.type = type;
    this.content = content;
  }

  public RequestType getType() {
    return this.type;
  }

  public String getContent() {
    return this.content;
  }
}
