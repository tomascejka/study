package cz.toce.learn.docker.restmimic.ping.boundary;

import javax.ws.rs.GET;
import javax.ws.rs.Path;

/**
 *
 * @author tomas.cejka
 *
 * @see http://adambien.blog/roller/abien/entry/simplest_possible_java_ee_8
 */
@Path("ping")
public class PingResource {    

    @GET
    public String ping() {
        return "Hello pong!";
    }

}
