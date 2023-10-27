public with sharing class GameForceNotificationController {
	@TestVisible
	private static Boolean throwException = false;

	@AuraEnabled(cacheable=true)
	public static Map<String, Object> getAchievementById(String achievementId){
		Map<String, Object> result = new Map<String, Object>();
		try {
			if (throwException) {
				throw new TestDataFactory.TestException();
			}

			List<Achievement__c> achievement = AchievementSelector.getInstance().getByIds(new Set<Id> { achievementId });
			result = ControllerResponse.success(AchievementsDataHelper.initAchievementCardData(achievement[0]));
		} catch (Exception e) {
			Logger.saveSingleLog('Unexpected exception caught in GameForceNotificationController. ' + e.getMessage() + '. ' + e.getStackTraceString());
			result = ControllerResponse.error('Unable to get Achievement by Id');
		}
		return result;
	}

	@AuraEnabled(cacheable=true)
	public static Map<String, Object> getClosesReachableAchievement(String userId){
		Map<String, Object> result = new Map<String, Object>();
		try {
			if (throwException) {
				throw new TestDataFactory.TestException();
			}

			DataWrappers.AchievementCardData closestAchievement = AchievementsDataHelper.getClosestAchievementForUser(userId);
			result = ControllerResponse.success(closestAchievement);
		} catch (Exception e) {
			Logger.saveSingleLog('Unexpected exception caught in LeaderboardController. ' + e.getMessage() + '. ' + e.getStackTraceString());
			result = ControllerResponse.error('Unable to get the closes achievement by user Id');
		}
		return result;
	}
}