from zeep import Client
from zeep import xsd

#
# @see https://docs.python-zeep.org/en/master/index.html
#
# Dalsi:
# - https://adriennedomingus.medium.com/using-zeep-to-make-soap-requests-in-python-c575ea0ee954
# - https://adriennedomingus.com/blog/using-zeep-to-make-soap-requests-in-python
# - https://webkul.com/blog/python-soap-clients-with-zeep/
# - https://hub.docker.com/r/jsorah/python-zeep-docker
# - https://github.com/mvantellingen/python-zeep
# - http://webservices.oorsprong.org/websamples.countryinfo/CountryInfoService.wso?WSDL
#
client = Client('http://webservices.oorsprong.org/websamples.countryinfo/CountryInfoService.wso?WSDL')

#
# @see https://docs.python-zeep.org/en/master/client.html#using-non-default-bindings
# usage: 
# client = Client("https://www.my.wsdl") # this will use default binding
# client_s12 = client.bind('CountryInfoService', 'CountryInfoServiceSoap12')
#
#<service name="CountryInfoService">
#   <documentation>This DataFlex Web Service opens up country information. 2 letter ISO codes are used for Country code. There are functions to retrieve the used Currency, Language, Capital City, Continent and Telephone code.</documentation>
#   <port name="CountryInfoServiceSoap" binding="tns:CountryInfoServiceSoapBinding">
#       <soap:address location="http://webservices.oorsprong.org/websamples.countryinfo/CountryInfoService.wso"/>
#   </port>
#   <port name="CountryInfoServiceSoap12" binding="tns:CountryInfoServiceSoapBinding12">
#       <soap12:address location="http://webservices.oorsprong.org/websamples.countryinfo/CountryInfoService.wso"/>
#   </port>
#</service>
#
client_s12 = client.bind('CountryInfoService', 'CountryInfoServiceSoap12')
result = client_s12.ListOfContinentsByName()
print("==========================================")
print(result)
print("==========================================")