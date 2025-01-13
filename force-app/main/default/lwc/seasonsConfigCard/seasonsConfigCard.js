import { LightningElement, wire  } from 'lwc';
import Toast from 'lightning/toast';
// APEX Controller methods
import getSeasonsConfig from '@salesforce/apex/SeasonsCardController.getSeasonsConfig';
import activateModifySeasons from '@salesforce/apex/SeasonsCardController.activateModifySeasons';
import deactivateSeasons from '@salesforce/apex/SeasonsCardController.deactivateSeasons';

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
            if (data.Success) {
                var result = data.Success;
                this.isActive = result.isActive
                this.originalCadence = result.cadence
                this.selectedCadence = result.cadence
                this.originalDate  = result.startDate
                this.selectedDate = result.startDate
                this.isConfigLoaded = true
            } else if (data.Error) {
                console.log(JSON.stringify(data.Error))
                Toast.show({
                    label: 'Something went wrong...',
                    message: 'We were unable to retrieve current Seasons Configuration. Please, try reloading the page.',
                    variant: 'error'
                }, this)
            }
        } else if (error) {
            console.log(JSON.stringify(error))
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

    async handleClick(event) {
        if (!this.isActive || this.isModified) {
            this.handleActivateModify()
        } else {
            this.handleDeactivate()
        }
    }

    async handleActivateModify() {
        try {
            var result = await activateModifySeasons({ cadence: this.selectedCadence, startDate: this.selectedDate });
            if (result.Success) {
                Toast.show({
                    label: this.isActive ? 'Modified' : 'Activated',
                    message: this.isActive ? 'Seasons cadence modified successfully' : 'Seasons feature activated successfully',
                    variant: 'success'
                }, this)
                this.originalCadence = this.selectedCadence
                this.originalDate = this.selectedDate
                this.isActive = true;
                this.isModified = false;
            } else if (result.Error) {
                console.log(JSON.stringify(data.Error))
                Toast.show({
                    label: 'Something went wrong...',
                    message: 'We were not able to activate or modify Seasons Feature. Please try refreshing the page and/or contact your System Administrator',
                    variant: 'error'
                }, this)
            }
        } catch (error) {
            console.log(JSON.stringify(error))
            Toast.show({
                label: 'Something went wrong...',
                message: 'We were not able to activate or modify Seasons Feature. Please try refreshing the page and/or contact your System Administrator',
                variant: 'error'
            }, this)
        }
    }

    async handleDeactivate() {
        try {
            var result = await deactivateSeasons();
            if (result.Success) {
                Toast.show({
                    label: 'Deactivated',
                    message: 'Seasons feature deactivated successfully',
                    variant: 'success'
                }, this)
                this.isActive = false;
            } else if (result.Error) {
                console.log(JSON.stringify(data.Error))
                Toast.show({
                    label: 'Something went wrong...',
                    message: 'We were not able to deactivate Seasons Feature. Please try refreshing the page and/or contact your System Administrator',
                    variant: 'error'
                }, this)
            }
        } catch (error) {
            console.log(JSON.stringify(error))
            Toast.show({
                label: 'Something went wrong...',
                message: 'We were not able to deactivate Seasons Feature. Please try refreshing the page and/or contact your System Administrator',
                variant: 'error'
            }, this)
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