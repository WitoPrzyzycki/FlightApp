import { LightningElement, wire, track } from 'lwc';
import getAllAirports from '@salesforce/apex/FlightCreatorController.getAllAirports';
import calculateAndSaveNewFlight from '@salesforce/apex/FlightCreatorController.calculateAndSaveNewFlight';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { labels } from 'c/labelUtilities'

export default class FlightCreator extends LightningElement {
    
    allAirportData =[];
    airportOptions = [];
    chosenDepartureAirport;
    chosenArrivalAirport;
    label = labels;
    @track createdFlight;


    get isResult() {
        if (this.createdFlight) {
            return true;
        }
        return false;
    }
    get name() {
        return this.createdFlight.name;
    }

    get departureAirportName() {
        return this.createdFlight.departureAirportName;
    }

    get arrivalAirportName() {
        return this.createdFlight.arrivalAirportName;
    }

    get distance() {
        return Math.round(this.createdFlight.distance * 100)/100;
    }
    @wire(getAllAirports)
    wiredAirports({error, data}) {
        if (data) {
            this.allAirportData = [...data];
            let airportData = [];
            data.forEach(airport => {
                airportData.push({label: airport.IATA_Code__c, value: airport.Id});
            });
            this.airportOptions = [...airportData];
        } else if (!data) {
            this.showToast(this.label.missingData, 'warning');
        } else if (error) {
            this.showToast(this.label.unexpectedErrorLabel, 'error');
        }
    }
    handleChange(event) {
        if (event.target.name == "departureAirport") {
            this.chosenDepartureAirport = event.target.value;
        } else if (event.target.name == "arrivalAirport") {
            this.chosenArrivalAirport = event.target.value;
        }
    }
    handleFlightCreation() {
        if (this.chosenDepartureAirport && this.chosenArrivalAirport && this.chosenDepartureAirport === this.chosenArrivalAirport) {
            this.showToast(this.label.makeSureBeforeSave, 'error');
        } else if (this.validateInputs()) {
            calculateAndSaveNewFlight({airports: this.getChosenAirportData()})
                .then((result) => {
                    this.createdFlight = result;
                }).catch((error) => {
                    this.showToast(error.body.message, 'error');
                });
        }
    }
    getChosenAirportData() {
        let chosenAirports = [];
        chosenAirports.push(this.allAirportData.find(el => el.Id == this.chosenDepartureAirport));
        chosenAirports.push(this.allAirportData.find(el => el.Id == this.chosenArrivalAirport));
        return chosenAirports;
    }
    validateInputs() {
        let isValid = true;
        this.template.querySelectorAll('lightning-combobox').forEach((field) => {
            if (!field.reportValidity()) {
                isValid = field.reportValidity();
            } 
        });
        return isValid;
    }
    showToast(mssage, variant) {
        this.dispatchEvent(new ShowToastEvent({
            message: mssage,
            variant: variant,
        }));
    }
}