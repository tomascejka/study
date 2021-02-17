package cz.toce.learn.docker.restmimic;

import javax.ws.rs.ApplicationPath;
import javax.ws.rs.core.Application;

/**
 * @author tomas.cejka
 * 
 * @see https://myshadesofgray.wordpress.com/2014/04/27/restful-web-service-using-jersey-and-no-web-xml/
 */
@ApplicationPath("resources")//tohle zaridi,ze nemusis resit nastaveni serveltu v web.xml
public class JAXRSConfiguration extends Application {

}
