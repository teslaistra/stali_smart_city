from SQLighter import SQLighter

class SocialStatisticsCalculator:

    def __init__(self, database):
        self.sqlighter = SQLighter(database)

    def compute_index(self, city_id, indicator_id, complaints_impact_level=0.2):
        """
        Считает финальный показатель. Результат работы -- число от 1 до 12.
        """
        complaints = self.sqlighter.get_weighted_complaints_proportion(city_id, indicator_id)
        answers = self.sqlighter.get_weighted_complaints_proportion(city_id, indicator_id)
        return ((complaints * complaints_impact_level + answers * (1 - complaints_impact_level)) + 1) * 6
