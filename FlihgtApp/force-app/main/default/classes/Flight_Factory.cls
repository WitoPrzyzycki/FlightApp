/**
 * Factory class for Flight__c sObject
 * 
 * @author Witold Przyżycki
 * @created 04.10.2022
 * 
 */
global with sharing class Flight_Factory {

    @AuraEnabled 
    global String name;
    @AuraEnabled
    global String departureAirportName;
    @AuraEnabled
    global String arrivalAirportName;
    @AuraEnabled 
    global Decimal distance;

    public Flight_Factory() {

    }
    /**
     * Factory method to copy Flight__c record
     * 
     * @author Witold Przyżycki
     * @created 04.10.2022
     * @param Flight__c object to copy as Flight_Factory
     * @return Flight_Factory object
     */
    global Flight_Factory cloneFlight(Flight__c flight) {
        this.distance = flight.Distance__c;
        this.name = flight.Name;
        return this;
    }

    /**
     * Factory method to set airports names
     * 
     * @author Witold Przyżycki
     * @created 04.10.2022
     * @param1 departure Airport Name as String
     * @param2 arrival Airport Name as String
     * @return Flight_Factory object with airport names populated
     */
    global Flight_Factory withNames(String departureAirportName, String arrivalAirportName) {
        this.departureAirportName = departureAirportName;
        this.arrivalAirportName = arrivalAirportName;
        return this;
    }

    /**
     * Factory method to fetch Flight_Factory record
     * 
     * @author Witold Przyżycki
     * @created 04.10.2022
     * @return Flight_Factory record
     */
    global Flight_Factory getRecord() {
        Flight_Factory flight = new Flight_Factory();
        flight.distance = this.distance;
        flight.name = this.name;
        flight.departureAirportName = this.departureAirportName;
        flight.arrivalAirportName = this.arrivalAirportName;
        return flight;
    }
}
