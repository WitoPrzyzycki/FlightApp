public with sharing class UtilityService {
    /**
     * Method  to calculate distance for given directions
     * 
     * @author Witold Przyżycki
     * @created 04.10.2022
     * @params latitude and longitude parameters for 2 places
     * @return distance in km as a Decimal
     */
    public static Decimal calculateDistance(Decimal latitude1, Decimal longitude1,Decimal latitude2, Decimal longitude2) {
        Integer earthRadius = 6371 * 1000; // in meters
        // Transform coordinates from degrees to radians
        Decimal latitudeRadians1 = latitude1 * Math.PI/180;
        Decimal latitudeRadians2 = latitude2 * Math.PI/180;
        // Latitude and longitude differences in radians
        Decimal latitudeDelta = (latitude2 - latitude1) * Math.PI/180;
        Decimal longitudeDelta = (longitude2 - longitude1) * Math.PI/180;
        Decimal a = Math.sin(latitudeDelta/2) * Math.sin(latitudeDelta/2) +
        Math.cos(latitudeRadians1) * Math.cos(latitudeRadians2) *
        Math.sin(longitudeDelta/2) * Math.sin(longitudeDelta/2);
        Decimal arc = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
        Decimal distance = earthRadius * arc; // in metres
        return distance/1000;
    }
    /**
     * Method  to identify that given fields has changed
     * 
     * @author Witold Przyżycki
     * @created 04.10.2022
     * @param1 new object to check
     * @param2 old object Map
     * @param3 Set of fields API names to check if is changed
     * @return Boolean true if one of given fields is changed
     */
    public static Boolean isFieldChanged(sObject obj, Map<Id, sObject> oldSObj2SObj, Set<String> fields) {
        if (oldSObj2SObj == null) {
            return true;
        }

        sObject oldObj = oldSObj2SObj.get(obj.Id);
        if (oldObj == null) {
            return true;
        }
        for (String field : fields) {
            if (obj.get(field) != oldObj.get(field)) {
                return true;
            }
        }
        return false;
    }
}
