import { LightningElement, wire  } from 'lwc';
import Toast from 'lightning/toast';
// APEX Controller methods
import getSeasonsConfig from '@salesforce/apex/SeasonsCardController.getSeasonsConfig';

export default class SeasonsConfigCard extends LightningElement {

    isConfigLoaded
    isModified
    isActive
    originalCadence
    selectedCadence
    originalDate
    selectedDate

    currentDateString = (new Date()).toISOString().split('T')[0];

    @wire(getSeasonsConfig)
    wiredSeasonsConfig({ data, error }) {
        if (data) {
            this.isActive = data.isActive
            this.originalCadence = data.cadence
            this.selectedCadence = data.cadence
            this.originalDate  = data.startDate
            this.selectedDate = data.startDate
            this.isConfigLoaded = true

        } else if (error) {
            Toast.show({
                label: 'Something went wrong...',
                message: 'We were unable to retrieve current Seasons Configuration. Please, try reloading the page.',
                variant: 'error'
            }, this)
        }
    }

    get cadenceOptions() {
        return [
            { label: 'Month', value: 'month' },
            { label: 'Quarter', value: 'quarter' },
            { label: 'Year', value: 'year' },
        ]
    }

    get buttonState() {
        var buttonState = {}
        if (!this.isActive || this.isModified) {
            buttonState.label = !this.isActive ? 'Activate' : 'Modify'
            buttonState.variant = 'brand'
            buttonState.disabled = !this.selectedCadence || this.selectedDate <= this.currentDateString
        } else {
            buttonState.label = 'Deactivate'
            buttonState.variant = 'destructive'
            buttonState.disabled = false
        }

        return buttonState
    }

    get dateValidity() {
        return false;
    }

    handleClick(event) {
        if (!this.isActive) {
            console.log('activate action')
        } else if (this.isModified) {
            console.log('modify action')
        } else {
            console.log('delete action')
        }
    }

    handleCadenceChange(event) {
        this.selectedCadence = event.detail.value
        this.isModifiedCheck()
    }

    handleDateChange(event) {
        this.selectedDate = event.detail.value
        var dateCmp = this.template.querySelector('.startDate');
        if (this.selectedDate <= this.currentDateString) {
            dateCmp.setCustomValidity('Season start date is expected to be in the future')
        } else {
            dateCmp.setCustomValidity('')
        }
        dateCmp.reportValidity()
        this.isModifiedCheck()
    }

    isModifiedCheck() {
        if (this.selectedCadence !== this.originalCadence || 
            this.selectedDate !== this.originalDate) {
            this.isModified = true
        } else {
            this.isModified = false
        }
    }
}