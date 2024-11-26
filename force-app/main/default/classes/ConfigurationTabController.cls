public with sharing class ConfigurationTabController {
	@TestVisible
	private static Boolean throwException = false;

	@AuraEnabled(cacheable=false)
	public static Map<String, Object> restoreDefaultAchievements(){
		Map<String, Object> result = new Map<String, Object>();
		try {
			if (throwException) {
				throw new TestDataFactory.TestException();
			}

			ScoreHubConfig helper = new ScoreHubConfig();
			helper.initOrResetDefaultConfiguration();

			result = ControllerResponse.success(System.Label.RestoreDefaultsConfirmation);
		} catch (Exception e) {
			Logger.saveSingleLog('Unexpected exception caught in ConfigurationTabController. ' + e.getMessage() + '. ' + e.getStackTraceString());
			result = ControllerResponse.error(System.Label.RestoreDefaultsException);
		}
		return result;
	}
}