public class BasicCalculatorController 
{

    public integer firstNum {get;set;}
    public integer secondfNum {get;set;}
    
    public integer result {get;set;}
    
    public void Addition()
    {
        result = firstNum + secondfNum;
    }
     public void Subtraction()
    {
        result = firstNum - secondfNum;
    }
     public void Multipication()
    {
        result = firstNum * secondfNum;
    }
     public void Division()
    {
        result = firstNum /secondfNum;
    }
}