Global class ScheduleAnnualRevenueCalculationBatch implements system.Schedulable 
{
    Global void execute(System.SchedulableContext sContext)
    {
        
// create the batch class object...
CalculateTotalAnnualREvenueBatch accountrevnuebatch = new CalculateTotalAnnualREvenueBatch();

// invoke the batch class..
database.executeBatch(accountrevnuebatch, 10);
    }

}