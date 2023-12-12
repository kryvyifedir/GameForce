import { LightningElement, api, wire } from 'lwc';
import LightningModal from 'lightning/modal';

// APEX Controller methods
import getUserInfoById from '@salesforce/apex/UserInfoController.getUserInfoById';
import getUserAchievementsById from '@salesforce/apex/AchievementsInfoController.getUserAchievementsById';

export default class CompareUsersModal extends LightningModal {
    @api content;
    userInfo1
    achievementsList1;
    userInfo2
    achievementsList2;

    isLoadingAchievements = true;

    // Getting current user info
    @wire(getUserInfoById, { userIds: "$content" })
    wiredUserInfo({ error, data }) {
        if (data) {
            if (data.Success) {
                this.userInfo1 = data.Success[this.content[0]]
                this.userInfo2 = data.Success[this.content[1]]
            } else if (data.Error) {
                console.log(JSON.stringify(data.Error))
            }
        } else if (error) {
            console.log(JSON.stringify(error))
        }
    }

    // Getting current user info
    @wire(getUserAchievementsById, { userIds: "$content" })
    wiredAchievementInfo({ error, data }) {
        if (data) {
            console.log(JSON.stringify(data))
            if (data.Success) {
                this.achievementsList1 = data.Success[this.content[0]]
                this.achievementsList2 = data.Success[this.content[1]]
                this.isLoadingAchievements = false;
            } else if (data.Error) {
                console.log(JSON.stringify(data.Error))
                this.isLoadingAchievements = false;
            }
        } else if (error) {
            console.log(JSON.stringify(error))
            this.isLoadingAchievements = false;
        }
    }

    handleOkay() {
        this.close('okay');
    }
}