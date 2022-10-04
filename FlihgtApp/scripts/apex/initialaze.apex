/**
 * script to initialaze data
 * 
 * @author Witold Przyżycki
 * @created 04.10.2022
 */
Airport__c newAirport1 = new Airport__c(
    IATA_Code__c = 'LCJ',
    Location__Latitude__s = 19.4666700,
    Location__Longitude__s = 51.750000, 
    Name = 'Łódź'
);

Airport__c newAirport2 = new Airport__c(
    IATA_Code__c = 'RDO',
    Location__Latitude__s = 21.213611,
    Location__Longitude__s = 51.389167, 
    Name = 'Radom'
);
List<Airport__c> airports = new List<Airport__c>{ newAirport1, newAirport2 };
insert airports;