import groovy.xml.Namespace
import groovy.xml.XmlParser

class XmlParserClazz {

    static run() {
        //def url  = 'http://www.webservicex.net/CurrencyConvertor.asmx?WSDL'
        def url = 'http://www.dataaccess.com/webservicesserver/numberconversion.wso?WSDL'
        def wsdl = new Namespace('http://schemas.xmlsoap.org/wsdl/', 'wsdl')
        def doc = new XmlParser().parse(url)

        println doc[wsdl.portType][wsdl.operation].'@name'
    }
}
