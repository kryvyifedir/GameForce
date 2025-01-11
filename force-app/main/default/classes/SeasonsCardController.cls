public with sharing class SeasonsCardController {
    @AuraEnabled(cacheable=true)
    public static DataWrappers.SeasonConfig getSeasonsConfig() {
        DataWrappers.SeasonConfig seassonsConfig = new DataWrappers.SeasonConfig();

        SeasonsConfiguration__c seasonsCustomSetting = SeasonsConfiguration__c.getOrgDefaults();
        if (seasonsCustomSetting.Id != null) {
            seassonsConfig.id = seasonsCustomSetting.Id;
            seassonsConfig.isActive = seasonsCustomSetting.IsActive__c;
            seassonsConfig.cadence = seasonsCustomSetting.Cadence__c;
            seassonsConfig.startDate = seasonsCustomSetting.StartDate__c;
        } else {
            seassonsConfig.isActive = false;
            seassonsConfig.cadence = 'month';
            Date nextMonth = Date.today().addMonths(1);
            seassonsConfig.startDate = Date.newInstance(nextMonth.year(), nextMonth.month(), 1);
        }

        return seassonsConfig;
    }
}