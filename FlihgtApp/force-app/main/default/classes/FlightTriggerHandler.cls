/**
 * Handler class for Flight__c trigger
 * 
 * @author Witold Przyżycki
 * @created 04.10.2022
 */
public with sharing class FlightTriggerHandler extends GeneralTriggerHandler{
    private FlightTriggerHandler() {}

    public static FlightTriggerHandler instance {
        get {
            if (instance == null) {
                instance = new FlightTriggerHandler();
            }
            return instance;
        }
        private set;
    }

    public override void beforeUpdate() {
        Flight_Service.recalculateFlightsDistances(Trigger.new, (Map<Id, Flight__c>) Trigger.oldMap);
    }
}
