public with sharing class SeasonsCardController {
	@TestVisible
	private static Boolean throwException = false;

	@AuraEnabled(cacheable=true)
	public static Map<String,Object> getSeasonsConfig() {
		Map<String, Object> result = new Map<String, Object>();
		try {
			if (throwException) {
				throw new TestDataFactory.TestException();
			}

			result = ControllerResponse.success(SeasonsConfigDataHelper.getDefaultConfiguration());
		} catch (Exception e) {
			Logger.saveSingleLog('Unexpected exception caught in SeasonsCardController. ' + e.getMessage() + '. ' + e.getStackTraceString());
			result = ControllerResponse.error('Unable to get Seassons Configuration');
		}
		return result;
	}

	@AuraEnabled(cacheable=false)
	public static Map<String,Object> activateModifySeasons(String cadence, Date startDate) {
		Map<String, Object> result = new Map<String, Object>();
		try {
			if (throwException) {
				throw new TestDataFactory.TestException();
			}

			SeasonsConfigDataHelper.upsertConfiguration(true, cadence, startDate);
			result = ControllerResponse.success(true);
		} catch (Exception e) {
			Logger.saveSingleLog('Unexpected exception caught in SeasonsCardController. ' + e.getMessage() + '. ' + e.getStackTraceString());
			result = ControllerResponse.error('Unable to get Seassons Configuration');
		}
		return result;
	}

	@AuraEnabled(cacheable=false)
	public static Map<String,Object> deactivateSeasons() {
		Map<String, Object> result = new Map<String, Object>();
		try {
			if (throwException) {
				throw new TestDataFactory.TestException();
			}

			DataWrappers.SeasonConfig config =  SeasonsConfigDataHelper.getDefaultConfiguration();
			SeasonsConfigDataHelper.upsertConfiguration(false, config.cadence, config.startDate);
			result = ControllerResponse.success(true);
		} catch (Exception e) {
			Logger.saveSingleLog('Unexpected exception caught in SeasonsCardController. ' + e.getMessage() + '. ' + e.getStackTraceString());
			result = ControllerResponse.error('Unable to get Seassons Configuration');
		}
		return result;
	}


}