package cz.tc.learn;

import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.core.Response;

import org.eclipse.microprofile.config.inject.ConfigProperty;

@Path("user")
public class UserResource {

  @Inject
  @ConfigProperty(name = "message")
  private String message;

  @GET
  public Response message() {
    return Response.ok(message).build();
  }

}
