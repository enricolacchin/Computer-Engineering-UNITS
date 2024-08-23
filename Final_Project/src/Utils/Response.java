package Utils;

public class Response {
  private final String responseText;
  private final boolean isBye;

  public Response(String responseText, boolean isBye) {
    this.responseText = responseText;
    this.isBye = isBye;
  }

  public String getFormattedResponse() {
    return this.responseText;
  }

  public boolean isBye() {
    return this.isBye;
  }
}