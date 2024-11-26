public with sharing class ScoreHubConfig implements InstallHandler {

	public void onInstall(InstallContext context) {
		if(context == null || context.previousVersion() == null) {
			this.initOrResetDefaultConfiguration();
		}
	}

	public void initOrResetDefaultConfiguration() {
		Map<String, Measurement__c> defaultMeasurementsByUniqueId = initOrResetDefaultMeasurementsConfiguration();
		upsert defaultMeasurementsByUniqueId.values();

		Map<String, Achievement__c> defaultAchivementsByName = initOrResetDefaultAchievementsConfiguration(defaultMeasurementsByUniqueId);
		upsert defaultAchivementsByName.values();
	}

	private Map<String, Measurement__c> initOrResetDefaultMeasurementsConfiguration() {
		Map<String, Measurement__c> defaultMeasurementsByUniqueId = new Map<String, Measurement__c>();
		Map<String, Measurement__c> existingMeasurementsByUniqueId = getExistingMeasurementByUniqueIdMap();
		for (String defaultMeasurementUniqueKey : Constants.MEASUREMENT_UNIQUE_IDS) { 
			Measurement__c defaultMeasurement = initDefaultMeasurementByUniqueKey(defaultMeasurementUniqueKey);
			if (existingMeasurementsByUniqueId.containsKey(defaultMeasurementUniqueKey)) {
				defaultMeasurement.Id = existingMeasurementsByUniqueId.get(defaultMeasurementUniqueKey).Id;
			}
			defaultMeasurementsByUniqueId.put(defaultMeasurementUniqueKey, defaultMeasurement);
		}
		return defaultMeasurementsByUniqueId;
	}

	private Map<String, Achievement__c> initOrResetDefaultAchievementsConfiguration(Map<String, Measurement__c> defaultMeasurements) {
		Map<String, Achievement__c> defaultAchievementsByName = new Map<String, Achievement__c>();
		Map<String, Achievement__c> existingAchievementsByName = getExistingAchievementsByNameMap();
		for (String defaultAchievementName : Constants.ACHIEVEMENT_NAMES) { 
			Achievement__c defaultAchievement = initDefaultAchievementByName(defaultAchievementName, defaultMeasurements);
			if (existingAchievementsByName.containsKey(defaultAchievementName)) {
				defaultAchievement.Id = existingAchievementsByName.get(defaultAchievementName).Id;
			}
			defaultAchievementsByName.put(defaultAchievementName, defaultAchievement);
		}
		return defaultAchievementsByName;
	}

	private Map<String, Measurement__c> getExistingMeasurementByUniqueIdMap() {
		Map<String, Measurement__c> existingMeasurementsByUniqueId = new Map<String, Measurement__c>();
		List<Measurement__c> existingMeasurements = MeasurementSelector.getInstance().getAll();
		for (Measurement__c existingMeasurement : existingMeasurements) { 
			existingMeasurementsByUniqueId.put(existingMeasurement.UniqueIdentifier__c, existingMeasurement);
		}
		return existingMeasurementsByUniqueId;
	}

	private Map<String, Achievement__c> getExistingAchievementsByNameMap() {
		Map<String, Achievement__c> existingAchievementsByName = new Map<String, Achievement__c>();
		List<Achievement__c> existingAchievements = AchievementSelector.getInstance().getAll();
		for (Achievement__c existingAchievement : existingAchievements) { 
			existingAchievementsByName.put(existingAchievement.Name, existingAchievement);
		}
		return existingAchievementsByName;
	}

	private Measurement__c initDefaultMeasurementByUniqueKey(String uniqueKey) {
		Measurement__c measurement = new Measurement__c(UniqueIdentifier__c = uniqueKey);
		if (uniqueKey == Constants.CREATED_LEADS_COUNTER_ID) {
			measurement.Description__c = 'Number of Leads that were created by use';
		} else if (uniqueKey == Constants.CONVERTED_LEADS_COUNTER_ID) {
			measurement.Description__c = 'Number of Leads that were converted by user';
		} else if (uniqueKey == Constants.COMPLETED_TASKS_COUNTER_ID) {
			measurement.Description__c = 'Number of Tasks that were completed by user';
		} else if (uniqueKey == Constants.CHATTER_POSTS_COUNTER_ID) {
			measurement.Description__c = 'Number of Chatter posts that were posted by user';
		} else if (uniqueKey == Constants.CLOSED_CASES_ID) {
			measurement.Description__c = 'Number of Cases closed by user';
		}
		return measurement;
	}

	private Achievement__c initDefaultAchievementByName(String name, Map<String, Measurement__c> measurements) {
		Achievement__c achievement = new Achievement__c(Name = name);
		if (name == Constants.CREATE_LEADS_1_NAME) {
			achievement.Measurement__c = measurements.get(Constants.CREATED_LEADS_COUNTER_ID).Id;
			achievement.UITitle__c = 'Sourcer';
			achievement.UIDescription__c = 'Created 10 Leads';
			achievement.Description__c = 'Standard Achievement, that can be reached by creating 10 different Leads';
			achievement.Goal__c = 10;
			achievement.Score__c = 10;
		} else if (name == Constants.CREATE_LEADS_2_NAME) {
			achievement.Measurement__c = measurements.get(Constants.CREATED_LEADS_COUNTER_ID).Id;
			achievement.UITitle__c = 'Tracker';
			achievement.UIDescription__c = 'Created 50 Leads';
			achievement.Description__c = 'Standard Achievement, that can be reached by creating 50 different Leads';
			achievement.Goal__c = 50;
			achievement.Score__c = 20;
		} else if (name == Constants.CREATE_LEADS_3_NAME) {
			achievement.Measurement__c = measurements.get(Constants.CREATED_LEADS_COUNTER_ID).Id;
			achievement.UITitle__c = 'Hunter';
			achievement.UIDescription__c = 'Created 100 Leads';
			achievement.Description__c = 'Standard Achievement, that can be reached by creating 100 different Leads';
			achievement.Goal__c = 100;
			achievement.Score__c = 50;
		} else if (name == Constants.CREATE_LEADS_4_NAME) {
			achievement.Measurement__c = measurements.get(Constants.CREATED_LEADS_COUNTER_ID).Id;
			achievement.UITitle__c = 'Ninja';
			achievement.UIDescription__c = 'Created 200 Leads';
			achievement.Description__c = 'Standard Achievement, that can be reached by creating 200 different Leads';
			achievement.Goal__c = 200;
			achievement.Score__c = 100;
		} else if (name == Constants.CONVERTED_LEADS_1_NAME) {
			achievement.Measurement__c = measurements.get(Constants.CONVERTED_LEADS_COUNTER_ID).Id;
			achievement.UITitle__c = 'Converter';
			achievement.UIDescription__c = 'Converted 10 Leads';
			achievement.Description__c = 'Standard Achievement, that can be reached by converting 10 different Leads to Accounts/Contacts/Opportunities';
			achievement.Goal__c = 10;
			achievement.Score__c = 10;
		} else if (name == Constants.CONVERTED_LEADS_2_NAME) {
			achievement.Measurement__c = measurements.get(Constants.CONVERTED_LEADS_COUNTER_ID).Id;
			achievement.UITitle__c = 'Transformer';
			achievement.UIDescription__c = 'Converted 50 Leads';
			achievement.Description__c = 'Standard Achievement, that can be reached by converting 50 different Leads to Accounts/Contacts/Opportunities';
			achievement.Goal__c = 50;
			achievement.Score__c = 20;
		} else if (name == Constants.CONVERTED_LEADS_3_NAME) {
			achievement.Measurement__c = measurements.get(Constants.CONVERTED_LEADS_COUNTER_ID).Id;
			achievement.UITitle__c = 'Metamorphist';
			achievement.UIDescription__c = 'Converted 100 Leads';
			achievement.Description__c = 'Standard Achievement, that can be reached by converting 100 different Leads to Accounts/Contacts/Opportunities';
			achievement.Goal__c = 100;
			achievement.Score__c = 100;
		} else if (name == Constants.COMPLETED_TASKS_1_NAME) {
			achievement.Measurement__c = measurements.get(Constants.COMPLETED_TASKS_COUNTER_ID).Id;
			achievement.UITitle__c = 'Closer';
			achievement.UIDescription__c = 'Complete 10 Tasks';
			achievement.Description__c = 'Standard Achievement, that can be reached by completing 10 different tasks';
			achievement.Goal__c = 10;
			achievement.Score__c = 10;
		} else if (name == Constants.COMPLETED_TASKS_2_NAME) {
			achievement.Measurement__c = measurements.get(Constants.COMPLETED_TASKS_COUNTER_ID).Id;
			achievement.UITitle__c = 'Taskmaster';
			achievement.UIDescription__c = 'Complete 50 Tasks';
			achievement.Description__c = 'Standard Achievement, that can be reached by completing 50 different tasks';
			achievement.Goal__c = 50;
			achievement.Score__c = 20;
		} else if (name == Constants.COMPLETED_TASKS_3_NAME) {
			achievement.Measurement__c = measurements.get(Constants.COMPLETED_TASKS_COUNTER_ID).Id;
			achievement.UITitle__c = 'Completionist';
			achievement.UIDescription__c = 'Complete 100 Tasks';
			achievement.Description__c = 'Standard Achievement, that can be reached by completing 100 different tasks';
			achievement.Goal__c = 100;
			achievement.Score__c = 20;
		} else if (name == Constants.COMPLETED_TASKS_4_NAME) {
			achievement.Measurement__c = measurements.get(Constants.COMPLETED_TASKS_COUNTER_ID).Id;
			achievement.UITitle__c = 'Executor';
			achievement.UIDescription__c = 'Complete 200 Tasks';
			achievement.Description__c = 'Standard Achievement, that can be reached by completing 200 different tasks';
			achievement.Goal__c = 200;
			achievement.Score__c = 100;
		} else if (name == Constants.CHATTER_POSTS_1_NAME) {
			achievement.Measurement__c = measurements.get(Constants.CHATTER_POSTS_COUNTER_ID).Id;
			achievement.UITitle__c = 'Enthusiast';
			achievement.UIDescription__c = 'Create 10 Chatter posts';
			achievement.Description__c = 'Standard Achievement, that can be reached by creating 10 posts in Chatter';
			achievement.Goal__c = 10;
			achievement.Score__c = 10;
		} else if (name == Constants.CHATTER_POSTS_2_NAME) { 
			achievement.Measurement__c = measurements.get(Constants.CHATTER_POSTS_COUNTER_ID).Id;
			achievement.UITitle__c = 'Messenger';
			achievement.UIDescription__c = 'Create 50 Chatter posts';
			achievement.Description__c = 'Standard Achievement, that can be reached by creating 50 posts in Chatter';
			achievement.Goal__c = 50;
			achievement.Score__c = 10;
		} else if (name == Constants.CHATTER_POSTS_3_NAME) { 
			achievement.Measurement__c = measurements.get(Constants.CHATTER_POSTS_COUNTER_ID).Id;
			achievement.UITitle__c = 'Collaborator';
			achievement.UIDescription__c = 'Create 100 Chatter posts';
			achievement.Description__c = 'Standard Achievement, that can be reached by creating 100 posts in Chatter';
			achievement.Goal__c = 100;
			achievement.Score__c = 20;
		} else if (name == Constants.CHATTER_POSTS_4_NAME) { 
			achievement.Measurement__c = measurements.get(Constants.CHATTER_POSTS_COUNTER_ID).Id;
			achievement.UITitle__c = 'Team Player';
			achievement.UIDescription__c = 'Create 200 Chatter posts';
			achievement.Description__c = 'Standard Achievement, that can be reached by creating 200 posts in Chatter';
			achievement.Goal__c = 200;
			achievement.Score__c = 50;
		} else if (name == Constants.CLOSED_CASES_1_NAME) { 
			achievement.Measurement__c = measurements.get(Constants.CLOSED_CASES_ID).Id;
			achievement.UITitle__c = 'Detective';
			achievement.UIDescription__c = 'Close 10 cases';
			achievement.Description__c = 'Standard Achievement, that can be reached by closing 10 Cases';
			achievement.Goal__c = 10;
			achievement.Score__c = 10;
		} else if (name == Constants.CLOSED_CASES_2_NAME) { 
			achievement.Measurement__c = measurements.get(Constants.CLOSED_CASES_ID).Id;
			achievement.UITitle__c = 'Watson';
			achievement.UIDescription__c = 'Close 50 cases';
			achievement.Description__c = 'Standard Achievement, that can be reached by closing 50 Cases';
			achievement.Goal__c = 50;
			achievement.Score__c = 20;
		} else if (name == Constants.CLOSED_CASES_3_NAME) { 
			achievement.Measurement__c = measurements.get(Constants.CLOSED_CASES_ID).Id;
			achievement.UITitle__c = 'Sherlock';
			achievement.UIDescription__c = 'Close 100 cases';
			achievement.Description__c = 'Standard Achievement, that can be reached by closing 50 Cases';
			achievement.Goal__c = 100;
			achievement.Score__c = 100;
		}

		return achievement;
	}

}