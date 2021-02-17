package cz.dckr.simplest.jaxws;

//import javax.jws.HandlerChain; 
import javax.jws.WebService;
import javax.xml.ws.BindingType;
import javax.xml.ws.WebServiceException;
import javax.xml.ws.soap.SOAPBinding;
import javax.xml.namespace.QName;
import javax.xml.soap.Detail;
import javax.xml.soap.SOAPConstants;
import javax.xml.soap.SOAPElement;
import javax.xml.soap.SOAPException;
import javax.xml.soap.SOAPFactory;
import javax.xml.soap.SOAPFault;
import javax.xml.ws.soap.SOAPFaultException;

import dckr.simplest.jaxws.api.InternalErrorExceptionFault;
import dckr.simplest.jaxws.api.SimplestWebServiceApiPortType;
import dckr.simplest.jaxws.service.HelloCheckedExceptionRequest;
import dckr.simplest.jaxws.service.HelloCheckedExceptionResponse;
import dckr.simplest.jaxws.service.HelloRequestType;
import dckr.simplest.jaxws.service.HelloResponseType;
import dckr.simplest.jaxws.service.HelloRuntimeExceptionRequest;
import dckr.simplest.jaxws.service.HelloRuntimeExceptionResponse;
import dckr.simplest.jaxws.service.HelloSoapFaultExceptionRequest;
import dckr.simplest.jaxws.service.HelloSoapFaultExceptionResponse;
import dckr.simplest.jaxws.service.HelloWebServiceExceptionRequest;
import dckr.simplest.jaxws.service.HelloWebServiceExceptionResponse;
import dckr.simplest.jaxws.service.InternalErrorException;
import java.util.Locale;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebService(serviceName = "SimplestWebServiceApi",  // viz. /definitions/service[@name]
        portName = "SimplestWebServiceApiSoap12Http", // viz. /definitions/service/port[@name]
        targetNamespace = "http://api.jaxws.simplest.dckr", // viz. /definitions[@targetNamespace]
        wsdlLocation = "META-INF/wsdl/SimplestWebServiceApi.wsdl", 
        endpointInterface = "dckr.simplest.jaxws.api.SimplestWebServiceApiPortType")// viz. složenina, viz. targetNamespace + /definitions/portType[@name]
@BindingType(SOAPBinding.SOAP12HTTP_BINDING)
//@HandlerChain(file = "ws-handler-chain.xml")
public class SimplestWebServiceApiImpl implements SimplestWebServiceApiPortType {

    private static final Logger LOG = Logger.getLogger(SimplestWebServiceApiImpl.class.getName());

    @Override
    public HelloResponseType hello(HelloRequestType parameters) {
        HelloResponseType response = new HelloResponseType();
        response.setResultCode("OK");
        response.setResultText("Approved");
        return response;
    }
    
    public static final String RUNTIME_EXCEPTION_MESSAGE= "RuntimeException: Not supported yet.";
    public static final String CHECKED_EXCEPTION_MESSAGE= "Shit happens, dontya?!";
    
    @Override
    public HelloRuntimeExceptionResponse helloRuntimeException(HelloRuntimeExceptionRequest parameters) {
        throw new RuntimeException(RUNTIME_EXCEPTION_MESSAGE);
    }

    @Override
    public HelloCheckedExceptionResponse helloCheckedException(HelloCheckedExceptionRequest parameters) throws InternalErrorExceptionFault {
        InternalErrorException faultInfo = new InternalErrorException();
        faultInfo.setMessage("Shit happens, dontya?!");
        throw new InternalErrorExceptionFault(CHECKED_EXCEPTION_MESSAGE, faultInfo, new IllegalStateException("deep-shit message, man"));
    }

    @Override
    public HelloWebServiceExceptionResponse helloWebServiceException(HelloWebServiceExceptionRequest parameters) {
        throw new WebServiceException("Web service exception.");
    }

    @Override
    public HelloSoapFaultExceptionResponse helloSoapFaultException(HelloSoapFaultExceptionRequest parameters) {
        try {
            SOAPFactory soapFactory = SOAPFactory.newInstance( SOAPConstants.SOAP_1_2_PROTOCOL );
            SOAPFault soapFault = soapFactory.createFault();
            soapFault.appendFaultSubcode( new QName( "http://api.fault.simplest.jaxws.javaee.learn.toce.cz", "SomethingDefined" ) );
            soapFault.setFaultRole( "http://api.fault.simplest.jaxws.javaee.learn.toce.cz/sample" );
            soapFault.addFaultReasonText( "SOAPFaultException happens.", Locale.getDefault() );
            Detail detail = soapFault.addDetail();
            SOAPElement soapElement = detail.addChildElement( new QName( "http://api.fault.simplest.jaxws.javaee.learn.toce.cz", "SomeSpecificReason" ) );
            soapElement.addTextNode( "TEST something detail section." );
            throw new SOAPFaultException( soapFault );
        } catch (SOAPException ex) {
            LOG.log(Level.SEVERE, null, ex);
            throw new WebServiceException("Soap fault exception fack up ...");
        }
    }

}