trigger FlightTrigger on Flight__c (before update) {
    FlightTriggerHandler.instance.handle();
}