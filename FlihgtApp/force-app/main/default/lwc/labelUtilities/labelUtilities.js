import missingData from '@salesforce/label/c.MissingData';
import unexpectedError from '@salesforce/label/c.UnexpectedError';
import makeSureBeforeSave from '@salesforce/label/c.MakeSureBeforeSave';
import createdFlight from '@salesforce/label/c.CreatedFlight';
import departureAirport from '@salesforce/label/c.DepartureAirport';
import arrivalAirport from '@salesforce/label/c.ArrivalAirport';
import flightDistance from '@salesforce/label/c.FlightDistance';
import distanceUnit from '@salesforce/label/c.distanceUnit';

const labels = {
    missingData,
    unexpectedError,
    makeSureBeforeSave,
    createdFlight,
    departureAirport,
    arrivalAirport,
    flightDistance,
    distanceUnit
}

export {labels};