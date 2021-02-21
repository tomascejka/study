import wslite.soap.SOAPClient
import wslite.soap.SOAPFaultException
import groovy.xml.Namespace
import groovy.xml.XmlParser

class WsLite {

    static run() {
        def client = new SOAPClient('http://www.holidaywebservice.com/Holidays/US/Dates/USHolidayDates.asmx')
        def response = client.send(SOAPAction: 'http://www.27seconds.com/Holidays/US/Dates/GetMothersDay') {
            body {
                GetMothersDay('xmlns': 'http://www.27seconds.com/Holidays/US/Dates/') {
                    year(2011)
                }
            }
        }

        assert "2011-05-08T00:00:00" == response.GetMothersDayResponse.GetMothersDayResult.text()
        assert 200 == response.httpResponse.statusCode
        assert "ASP.NET" == response.httpResponse.headers['X-Powered-By']
    }

    void fun() {
        try {
            def url = 'http://www.dataaccess.com/webservicesserver/numberconversion.wso?wsdl'
            def client = new SOAPClient('http://www.dataaccess.com/webservicesserver/numberconversion.wso')


            def wsdl = new Namespace('http://schemas.xmlsoap.org/wsdl/', 'wsdl')
            def xs = new Namespace('http://www.w3.org/2001/XMLSchema', 'xs')
            def soap= new Namespace('http://schemas.xmlsoap.org/wsdl/soap/','soap')
            def soap12 = new Namespace('http://schemas.xmlsoap.org/wsdl/soap12/','soap12')

            def definitions = new XmlParser().parse(url)
            def targetNamespace = definitions.'@targetNamesace'

            //System.out.println(definitions);

            def messages = definitions[wsdl.message]//[import]

            System.out.println("Messages:")
            definitions[wsdl.message].each { message ->
                System.out.println("\t"+message.'@name');
                //System.out.println(theimport.'@schemaLocation');
                //System.out.println(theimport.'@namespace');
            }
            System.out.println("Port:")
            definitions[wsdl.portType].each { port ->
                System.out.println("\t- "+port.'@name');
            }
            System.out.println("\tOperations:")
            definitions[wsdl.portType][wsdl.operation].each { port ->
                System.out.println("\t\t- "+port.'@name');
            }
            System.out.println("Binding:")
            definitions[wsdl.binding].each { binding ->
                System.out.println("\t"+binding.'@name');
                System.out.println("\t\tSOAP Binding:")
                definitions[wsdl.binding][soap.binding].each { bind ->
                    System.out.println("\t\t- style="+bind.'@style'+", transport="+bind.'@transport');
                }
                definitions[wsdl.binding][wsdl.operation].each { operation ->
                    System.out.println("\t\t- "+operation.'@name');
                }
            }

/*
            String city = 'Stockholm'
            String country = 'Sweden'

            def weatherResponse = client.send() {
                version SOAPVersion.V1_2        // SOAPVersion.V1_1 is default
                soapNamespacePrefix "soap12"      // "soap-env" is default
                envelopeAttributes "xmlns:ns1": "http://www.webserviceX.NET"
                header {}
                body {
                    'ns1:GetWeather' {
                        'ns1:CityName'(city)
                        'ns1:CountryName'(country)
                    }
                }
            }*/
        } catch (SOAPFaultException sfe) {
            println sfe.message // faultcode/faultstring for 1.1 or Code/Reason for 1.2
            println sfe.text    // prints SOAP Envelope
            println sfe.httpResponse.statusCode
            println sfe.fault.detail.text() // sfe.fault is a GPathResult of Envelope/Body/Fault
        }
    }
}