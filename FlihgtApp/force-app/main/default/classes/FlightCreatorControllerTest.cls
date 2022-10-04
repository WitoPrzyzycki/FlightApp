@isTest
public with sharing class FlightCreatorControllerTest {
    
    @TestSetup
    static void setupData() {
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
    }

    @isTest
    public static void calculateAndSaveNewFlightTest() {
        List<Airport__c> airports = [SELECT Id, Location__Latitude__s, Location__Longitude__s, Name FROM Airport__c ORDER BY Name DESC];

        Test.startTest();
        Flight_Factory resultFlight = FlightCreatorController.calculateAndSaveNewFlight(airports);
        Test.stopTest();

        System.assert(resultFlight.Name == 'Łódź-Radom');
        System.assert(resultFlight.departureAirportName == airports[0].Name);
        System.assert(resultFlight.arrivalAirportName == airports[1].Name);
    }
    @isTest
    public static void calculateAndSaveFlightAirportNullErrorTest() {
        List<Airport__c> airports = [SELECT Id FROM Airport__c ORDER BY Name DESC LIMIT 1];
        Flight_Factory resultFlight;
        Boolean exceptionThrown = false;

        Test.startTest();
        try {
            resultFlight = FlightCreatorController.calculateAndSaveNewFlight(airports);
        } catch(Exception e) {
            exceptionThrown = true;
        }
        Test.stopTest();

        System.assert(exceptionThrown);
    }
    
    @isTest
    public static void calculateAndSaveFlightErrorTest() {
        Profile standardUserP = [
            SELECT Id, Name
            FROM Profile
            WHERE Name = 'Standard User'
        ];

        User user = new User(
            Username = 'standardUser@test.pl',
            LastName = 'Testowy',
            ProfileId = standardUserP.Id,
            Email = 'test@test.pl',
            Alias = 'Test',
            TimeZoneSidKey = 'Europe/Prague',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'ISO-8859-1',
            LanguageLocaleKey = 'en_US'
        );
        insert user;
        List<Airport__c> airports = [SELECT Id FROM Airport__c ORDER BY Name DESC];
        Flight_Factory resultFlight;
        Boolean exceptionThrown = false;

        Test.startTest();
        System.runAs(user) {
            try {
                resultFlight = FlightCreatorController.calculateAndSaveNewFlight(airports);
            } catch(Exception e) {
                System.debug(e.getMessage());
                exceptionThrown = true;
            }
        }
        Test.stopTest();

        System.assert(exceptionThrown);
    }
}