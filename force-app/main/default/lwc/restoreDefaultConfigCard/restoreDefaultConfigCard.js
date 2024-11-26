import { LightningElement } from 'lwc';
import LightningConfirm from 'lightning/confirm';
import Toast from 'lightning/toast';

// APEX Controller methods
import restoreDefaults from '@salesforce/apex/ConfigurationTabController.restoreDefaultAchievements';

//Custom Labels
import Error from '@salesforce/label/c.Error';
import Success from '@salesforce/label/c.Success'
import RestoreDefaultsHeader from '@salesforce/label/c.RestoreDefaultsHeader';
import RestoreDefaultsHelptext from '@salesforce/label/c.RestoreDefaultsHelptext';
import RestoreDefaultsConfirmDialogLabel from '@salesforce/label/c.RestoreDefaultsConfirmDialogLabel';
import RestoreDefaultsConfirmDialogMessage from '@salesforce/label/c.RestoreDefaultsConfirmDialogMessage';
import RestoreButtonLabel from '@salesforce/label/c.RestoreButtonLabel';


export default class RestoreDefaultConfigCard extends LightningElement {

    labels = {
        Error, Success, RestoreDefaultsHeader, RestoreDefaultsHelptext, RestoreDefaultsConfirmDialogLabel, RestoreDefaultsConfirmDialogMessage, RestoreButtonLabel
    };

    async handleConfirmClick() {
        const result = await LightningConfirm.open({
            // variant: 'headerless',
            theme: 'warning',
            label: this.labels.RestoreDefaultsConfirmDialogLabel,
            message: this.labels.RestoreDefaultsConfirmDialogMessage
        });

        if (result) {
            try {
                const restoreResult = await restoreDefaults()
                if (restoreResult.Success) {
                    Toast.show({
                        label: this.labels.Success,
                        message: restoreResult.Success,
                        variant: 'success'
                    }, this);
                } else {
                    Toast.show({
                        label: this.labels.Error,
                        message: restoreResult.Error,
                        variant: 'error'
                    }, this);
                }
            } catch (error) {
                Toast.show({
                    label: this.labels.Error,
                    message: JSON.stringify(error),
                    variant: 'error'
                }, this);
            }

        }
    }
}