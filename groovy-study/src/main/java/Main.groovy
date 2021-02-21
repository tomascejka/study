class Main {

    static void main(String[] args) {
        println("Hello, Groovy!")
        def url = 'http://www.dataaccess.com/webservicesserver/numberconversion.wso?WSDL'

        XmlParserClazz.run();
        //WsLite.run()
        new WsLite().fun()
    }
}