//
//  CityBreakdown.swift
//  BestPlaceToLive
//
//  Created by Jeffrey Santana on 11/12/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import Foundation

struct CityBreakdown: Codable {
	let airPollutionTelescore: Double
	let airportHubIndexDetail: Int
	let airportHubTelescore: Double
	let apartmentRentLarge: Int
	let apartmentRentMedium: Int
	let apartmentRentSmall: Int
	let avgCommuteTime: Int
	let avgCommuteTimeScore: String
	let businessFreedom: Double
	let businessFreedomTelescore: Double
	let cleanlinessTelescore: Double
	let companyProfitTaxRate: Double
	let companyProfitTaxRateTelescore: Double
	let consumerPriceIndexTelescore: Double
	let corruptionFreedom: Int
	let corruptionFreedomTelescore: Double
	let costApples: Double
	let costBread: Double
	let costCappuccino: Double
	let costCinema: Int
	let costFitnessClub: Int
	let costImportBeer: Double
	let costOfLiving: Int
	let costPublicTransport: Int
	let costRestaurantMeal: Int
	let costTaxi: Double
	let country: String
	let coworkingSpacesTelescore: Int
	let crimeRateTelescore: Double
	let cultureArtGalleriesTelescore: Double
	let cultureArtGalleriesVenueCount: Int
	let cultureCinemasVenueCount: Int
	let cultureCinemaTelescore: Double
	let cultureComedyClubsTelescore: Double
	let cultureComedyClubsVenueCount: Int
	let cultureConcertsTelescore: Int
	let cultureConcertsVenueCount: Int
	let cultureHistoricalSitesTelescore: Double
	let cultureHistoricalSitesVenueCount: Int
	let cultureMuseumsTelescore: Double
	let cultureMuseumsVenueCount: Int
	let culturePerformingArtsTelescore: Double
	let culturePerformingArtsVenueCount: Int
	let cultureSportsTelescore: Double
	let cultureSportsVenueCount: Int
	let cultureZoosTelescore: Double
	let cultureZoosVenueCount: Int
	let currencyUrbanArea: String
	let currencyUrbanAreaExchangeRate: Int
	let drinkingWaterQualityTelescore: Double
	let elderlyPeople: Double
	let elevation: Int
	let elevationHills: Int
	let elevationMountains: Int
	let elevationPeaks: Double
	let elevationPeaksTelescore: Double
	let employerSocialTaxesCapSocSec: Int
	let employerSocialTaxesOther: Double
	let employerSocialTaxesSocSec: Double
	let englishSkillsDetail: Int
	let englishSkillsTelescore: Int
	let eventsCount: Int
	let eventsLast12Months: Int
	let eventsTelescore: Int
	let fullName: String
	let funderbeamTotalStartups: Int
	let funderbeamVentureCapitalTelescore: Int
	let fundingAcceleratorNames: String
	let fundingAcceleratorsDetail: Int
	let gdpGrowthRate: Double
	let gdpGrowthRateTelescore: Double
	let gdpPerCapita: Double
	let gdpPerCapitaTelescore: Double
	let geonameId: Int
	let gradeBusinessFreedom: String
	let gradeCommute: String
	let gradeCostOfLiving: String
	let gradeEconomy: String
	let gradeEducation: String
	let gradeEnvironmentalQuality: String
	let gradeHealthcare: String
	let gradeHousing: String
	let gradeInternetAccess: String
	let gradeLeisureAndCulture: String
	let gradeOutdoors: String
	let gradeSafety: String
	let gradeStartups: String
	let gradeTaxation: String
	let gradeTolerance: String
	let gradeTotal: String
	let gradeTravelConnectivity: String
	let gradeVentureCapital: String
	let gunDeathRate: Double
	let gunDeathScoreTelescore: Double
	let gunOwnership: Double
	let gunOwnershipScoreTelescore: Double
	let gunScoreTelescore: Double
	let healthcareCostTelescore: Double
	let healthcareLifeExpectancy: Double
	let healthcareLifeExpectancyTelescore: Double
	let healthcareQualityTelescore: Double
	let humanCitiesPageUrls: Double
	let id: Int
	let incomeTaxTelescore: Double
	let laborRestrictions: Double
	let laborRestrictionsTelescore: Int
	let lgbtDetailAdoption: String
	let lgbtDetailAgeOfConsent: String
	let lgbtDetailChangingGender: String
	let lgbtDetailConversionTherapy: String
	let lgbtDetailDiscrimination: String
	let lgbtDetailDonatingBlood: String
	let lgbtDetailEmploymentDiscrimination: String
	let lgbtDetailHomosexuality: String
	let lgbtDetailHousingDiscrimination: String
	let lgbtDetailMarriage: String
	let lgbtIndex: Double
	let lgbtIndexTelescore: Double
	let lifeExpectancy: Double
	let location: Double
	let medianAge: Double
	let meetupsDetailTotalEvents: Int
	let meetupsGroups: Int
	let meetupsMembers: Int
	let meetupsTelescore: Int
	let name: String
	let networkDownload: Double
	let networkDownloadTelescore: Double
	let networkUpload: Double
	let networkUploadTelescore: Double
	let photo: Double
	let pisaDetailHappiness: Double
	let pisaDetailMathHighPerformers: Double
	let pisaDetailMathLowPerformers: Double
	let pisaDetailMathMeanScores: Double
	let pisaDetailReadingHighPerformers: Double
	let pisaDetailReadingLowPerformers: Double
	let pisaDetailReadingMeanScores: Double
	let pisaDetailScienceHighPerformers: Double
	let pisaDetailScienceLowPerformers: Double
	let pisaDetailScienceMeanScores: Double
	let pisaMathsRanking: Int
	let pisaRanking: Int
	let pisaRankingTelescore: Double
	let pisaReadingRanking: Int
	let pisaScienceRanking: Int
	let population: Int
	let populationSize: Double
	let populationUaCenterDensity: Double
	let populationUaDensity: Double
	let qualityOfUniversitiesTelescore: Int
	let rentIndexTelescore: Double
	let restaurantPriceIndex: Double
	let scoreBusinessFreedom: Double
	let scoreCommute: Double
	let scoreCostOfLiving: Double
	let scoreEconomy: Double
	let scoreEducation: Double
	let scoreEnvironmentalQuality: Double
	let scoreHealthcare: Double
	let scoreHousing: Double
	let scoreInternetAccess: Double
	let scoreLeisureAndCulture: Double
	let scoreOutdoors: Double
	let scoreSafety: Double
	let scoreStartups: Double
	let scoreTaxation: Double
	let scoreTolerance: Double
	let scoreTotal: Double
	let scoreTravelConnectivity: Double
	let scoreVentureCapital: Double
	let seasideAccessTelescore: Int
	let seasideSeaside: Int
	let shortName: String
	let spokenLanguages: String
	let startupClimateInvestors: Int
	let startupClimateNewStartups: Int
	let startupClimateNewStartupsTelescore: Int
	let startupClimateSceneTelescore: Double
	let startupClimateStartupsTelescore: Int
	let startupJobsAvailable: Int
	let startupJobsAvailableTelescore: Int
	let startupSalaries: Int
	let startupSalariesDetail: Int
	let state: Int
	let taxVat: Double
	let timeOverheadCompanyTaxes: Int
	let timeToOpenBusiness: Double
	let timeToOpenBusinessTelescore: Double
	let timeZone: String
	let toleranceTowardsMinoritiesTelescore: Double
	let trafficIndexTelescore: Double
	let trainTransportTelescore: Double
	let unemploymentRate: Double
	let universitiesBestRankedName: String
	let universitiesBestRankedRank: Int
	let urbanGreeneryTelescore: Double
	let weatherAvDayLength: Double
	let weatherAverageHigh: Double
	let weatherAverageLow: Double
	let weatherAvNumberClearDays: Int
	let weatherAvNumberRainyDays: Int
	let weatherAvPercentChanceClearSkies: Double
	let weatherAvPossibilitySunshine: Double
	let weatherSunshineAmount: Double
	let weatherType: String
	let workfromCoworkingSpacesCount: Int
	
	enum CodingKeys: String, CodingKey {
		case id = "_id"
		case airPollutionTelescore = "air-pollution-telescore"
		case airportHubIndexDetail = "airport-hub-index-detail"
		case airportHubTelescore = "airport-hub-telescore"
		case apartmentRentLarge = "apartment-rent-large"
		case apartmentRentMedium = "apartment-rent-medium"
		case apartmentRentSmall = "apartment-rent-small"
		case avgCommuteTime = "avg_commute_time"
		case avgCommuteTimeScore = "avg_commute_time_score"
		case businessFreedom = "business-freedom"
		case businessFreedomTelescore = "business-freedom-telescore"
		case cleanlinessTelescore = "cleanliness-telescore"
		case companyProfitTaxRate = "company-profit-tax-rate"
		case companyProfitTaxRateTelescore = "company-profit-tax-rate-telescore"
		case consumerPriceIndexTelescore = "consumer-price-index-telescore"
		case corruptionFreedom = "corruption-freedom"
		case corruptionFreedomTelescore = "corruption-freedom-telescore"
		case costOfLiving = "cost_of_living"
		case costApples = "cost-apples"
		case costBread = "cost-bread"
		case costCappuccino = "cost-cappuccino"
		case costCinema = "cost-cinema"
		case costFitnessClub = "cost-fitness-club"
		case costImportBeer = "cost-import-beer"
		case costPublicTransport = "cost-public-transport"
		case costRestaurantMeal = "cost-restaurant-meal"
		case costTaxi = "cost-taxi"
		case country = "country"
		case coworkingSpacesTelescore = "coworking-spaces-telescore"
		case crimeRateTelescore = "crime-rate-telescore"
		case cultureArtGalleriesTelescore = "culture-art-galleries-telescore"
		case cultureArtGalleriesVenueCount = "culture-art-galleries-venue-count"
		case cultureCinemaTelescore = "culture-cinema-telescore"
		case cultureCinemasVenueCount = "culture-cinemas-venue-count"
		case cultureComedyClubsTelescore = "culture-comedy-clubs-telescore"
		case cultureComedyClubsVenueCount = "culture-comedy-clubs-venue-count"
		case cultureConcertsTelescore = "culture-concerts-telescore"
		case cultureConcertsVenueCount = "culture-concerts-venue-count"
		case cultureHistoricalSitesTelescore = "culture-historical-sites-telescore"
		case cultureHistoricalSitesVenueCount = "culture-historical-sites-venue-count"
		case cultureMuseumsTelescore = "culture-museums-telescore"
		case cultureMuseumsVenueCount = "culture-museums-venue-count"
		case culturePerformingArtsTelescore = "culture-performing-arts-telescore"
		case culturePerformingArtsVenueCount = "culture-performing-arts-venue-count"
		case cultureSportsTelescore = "culture-sports-telescore"
		case cultureSportsVenueCount = "culture-sports-venue-count"
		case cultureZoosTelescore = "culture-zoos-telescore"
		case cultureZoosVenueCount = "culture-zoos-venue-count"
		case currencyUrbanArea = "currency-urban-area"
		case currencyUrbanAreaExchangeRate = "currency-urban-area-exchange-rate"
		case drinkingWaterQualityTelescore = "drinking-water-quality-telescore"
		case elderlyPeople = "elderly-people"
		case elevation = "elevation"
		case elevationHills = "elevation-hills"
		case elevationMountains = "elevation-mountains"
		case elevationPeaks = "elevation-peaks"
		case elevationPeaksTelescore = "elevation-peaks-telescore"
		case employerSocialTaxesCapSocSec = "employer-social-taxes-cap-soc-sec"
		case employerSocialTaxesOther = "employer-social-taxes-other"
		case employerSocialTaxesSocSec = "employer-social-taxes-soc-sec"
		case englishSkillsDetail = "english-skills-detail"
		case englishSkillsTelescore = "english-skills-telescore"
		case eventsCount = "events-count"
		case eventsLast12Months = "events-last-12-months"
		case eventsTelescore = "events-telescore"
		case fullName = "full_name"
		case funderbeamTotalStartups = "funderbeam-total-startups"
		case funderbeamVentureCapitalTelescore = "funderbeam-venture-capital-telescore"
		case fundingAcceleratorNames = "funding-accelerator-names"
		case fundingAcceleratorsDetail = "funding-accelerators-detail"
		case gdpGrowthRate = "gdp-growth-rate"
		case gdpGrowthRateTelescore = "gdp-growth-rate-telescore"
		case gdpPerCapita = "gdp-per-capita"
		case gdpPerCapitaTelescore = "gdp-per-capita-telescore"
		case geonameId = "geoname_id"
		case gradeBusinessFreedom = "grade_business_freedom"
		case gradeCommute = "grade_commute"
		case gradeCostOfLiving = "grade_cost_of_living"
		case gradeEconomy = "grade_economy"
		case gradeEducation = "grade_education"
		case gradeEnvironmentalQuality = "grade_environmental_quality"
		case gradeHealthcare = "grade_healthcare"
		case gradeHousing = "grade_housing"
		case gradeInternetAccess = "grade_internet_access"
		case gradeLeisureAndCulture = "grade_leisure_&_culture"
		case gradeOutdoors = "grade_outdoors"
		case gradeSafety = "grade_safety"
		case gradeStartups = "grade_startups"
		case gradeTaxation = "grade_taxation"
		case gradeTolerance = "grade_tolerance"
		case gradeTotal = "grade_total"
		case gradeTravelConnectivity = "grade_travel_connectivity"
		case gradeVentureCapital = "grade_venture_capital"
		case gunDeathRate = "gun-death-rate"
		case gunDeathScoreTelescore = "gun-death-score-telescore"
		case gunOwnership = "gun-ownership"
		case gunOwnershipScoreTelescore = "gun-ownership-score-telescore"
		case gunScoreTelescore = "gun-score-telescore"
		case healthcareCostTelescore = "healthcare-cost-telescore"
		case healthcareLifeExpectancy = "healthcare-life-expectancy"
		case healthcareLifeExpectancyTelescore = "healthcare-life-expectancy-telescore"
		case healthcareQualityTelescore = "healthcare-quality-telescore"
		case humanCitiesPageUrls = "human-cities-page-urls"
		case incomeTaxTelescore = "income-tax-telescore"
		case laborRestrictions = "labor-restrictions"
		case laborRestrictionsTelescore = "labor-restrictions-telescore"
		case lgbtDetailAdoption = "lgbt-detail-adoption"
		case lgbtDetailAgeOfConsent = "lgbt-detail-age-of-consent"
		case lgbtDetailChangingGender = "lgbt-detail-changing-gender"
		case lgbtDetailConversionTherapy = "lgbt-detail-conversion-therapy"
		case lgbtDetailDiscrimination = "lgbt-detail-discrimination"
		case lgbtDetailDonatingBlood = "lgbt-detail-donating-blood"
		case lgbtDetailEmploymentDiscrimination = "lgbt-detail-employment-discrimination"
		case lgbtDetailHomosexuality = "lgbt-detail-homosexuality"
		case lgbtDetailHousingDiscrimination = "lgbt-detail-housing-discrimination"
		case lgbtDetailMarriage = "lgbt-detail-marriage"
		case lgbtIndex = "lgbt-index"
		case lgbtIndexTelescore = "lgbt-index-telescore"
		case lifeExpectancy = "life-expectancy"
		case location = "location"
		case medianAge = "median-age"
		case meetupsDetailTotalEvents = "meetups-detail-total-events"
		case meetupsGroups = "meetups-groups"
		case meetupsMembers = "meetups-members"
		case meetupsTelescore = "meetups-telescore"
		case name = "name"
		case networkDownload = "network-download"
		case networkDownloadTelescore = "network-download-telescore"
		case networkUpload = "network-upload"
		case networkUploadTelescore = "network-upload-telescore"
		case photo = "photo"
		case pisaDetailHappiness = "pisa-detail-happiness"
		case pisaDetailMathHighPerformers = "pisa-detail-math-high-performers"
		case pisaDetailMathLowPerformers = "pisa-detail-math-low-performers"
		case pisaDetailMathMeanScores = "pisa-detail-math-mean-scores"
		case pisaDetailReadingHighPerformers = "pisa-detail-reading-high-performers"
		case pisaDetailReadingLowPerformers = "pisa-detail-reading-low-performers"
		case pisaDetailReadingMeanScores = "pisa-detail-reading-mean-scores"
		case pisaDetailScienceHighPerformers = "pisa-detail-science-high-performers"
		case pisaDetailScienceLowPerformers = "pisa-detail-science-low-performers"
		case pisaDetailScienceMeanScores = "pisa-detail-science-mean-scores"
		case pisaMathsRanking = "pisa-maths-ranking"
		case pisaRanking = "pisa-ranking"
		case pisaRankingTelescore = "pisa-ranking-telescore"
		case pisaReadingRanking = "pisa-reading-ranking"
		case pisaScienceRanking = "pisa-science-ranking"
		case population = "population"
		case populationSize = "population-size"
		case populationUaCenterDensity = "population-ua-center-density"
		case populationUaDensity = "population-ua-density"
		case qualityOfUniversitiesTelescore = "quality-of-universities-telescore"
		case rentIndexTelescore = "rent-index-telescore"
		case restaurantPriceIndex = "restaurant-price-index"
		case scoreBusinessFreedom = "score_business_freedom"
		case scoreCommute = "score_commute"
		case scoreCostOfLiving = "score_cost_of_living"
		case scoreEconomy = "score_economy"
		case scoreEducation = "score_education"
		case scoreEnvironmentalQuality = "score_environmental_quality"
		case scoreHealthcare = "score_healthcare"
		case scoreHousing = "score_housing"
		case scoreInternetAccess = "score_internet_access"
		case scoreLeisureAndCulture = "score_leisure_&_culture"
		case scoreOutdoors = "score_outdoors"
		case scoreSafety = "score_safety"
		case scoreStartups = "score_startups"
		case scoreTaxation = "score_taxation"
		case scoreTolerance = "score_tolerance"
		case scoreTotal = "score_total"
		case scoreTravelConnectivity = "score_travel_connectivity"
		case scoreVentureCapital = "score_venture_capital"
		case seasideAccessTelescore = "seaside-access-telescore"
		case seasideSeaside = "seaside-seaside"
		case shortName = "short_name"
		case spokenLanguages = "spoken-languages"
		case startupClimateInvestors = "startup-climate-investors"
		case startupClimateNewStartups = "startup-climate-new-startups"
		case startupClimateNewStartupsTelescore = "startup-climate-new-startups-telescore"
		case startupClimateSceneTelescore = "startup-climate-scene-telescore"
		case startupClimateStartupsTelescore = "startup-climate-startups-telescore"
		case startupJobsAvailable = "startup-jobs-available"
		case startupJobsAvailableTelescore = "startup-jobs-available-telescore"
		case startupSalaries = "startup-salaries"
		case startupSalariesDetail = "startup-salaries-detail"
		case state = "state"
		case taxVat = "tax-vat"
		case timeZone = "time_zone"
		case timeOverheadCompanyTaxes = "time-overhead-company-taxes"
		case timeToOpenBusiness = "time-to-open-business"
		case timeToOpenBusinessTelescore = "time-to-open-business-telescore"
		case toleranceTowardsMinoritiesTelescore = "tolerance-towards-minorities-telescore"
		case trafficIndexTelescore = "traffic-index-telescore"
		case trainTransportTelescore = "train-transport-telescore"
		case unemploymentRate = "unemployment-rate"
		case universitiesBestRankedName = "universities-best-ranked-name"
		case universitiesBestRankedRank = "universities-best-ranked-rank"
		case urbanGreeneryTelescore = "urban-greenery-telescore"
		case weatherAvDayLength = "weather-av-day-length"
		case weatherAvNumberClearDays = "weather-av-number-clear-days"
		case weatherAvNumberRainyDays = "weather-av-number-rainy-days"
		case weatherAvPercentChanceClearSkies = "weather-av-percent-chance-clear-skies"
		case weatherAvPossibilitySunshine = "weather-av-possibility-sunshine"
		case weatherAverageHigh = "weather-average-high"
		case weatherAverageLow = "weather-average-low"
		case weatherSunshineAmount = "weather-sunshine-amount"
		case weatherType = "weather-type"
		case workfromCoworkingSpacesCount = "workfrom-coworking-spaces-count"
	}
}
