public class ArithmeticClass 
{
    public integer firstNum = 1000;
    public integer secondNum = 555;
    
    public void Add()
    {
        System.debug('Addition result is ... '+ (firstNum+ secondNum));
    }
    public void Sub()
    {
        system.debug('Subtraction is.... '+(firstNum - secondNum));
    }
    public void Mul()
    {
        System.debug('Multipication is.... '+ (firstNum * secondNum));
    }
    public void Div()
    {
        System.debug('Division is... '+ (firstNum / secondNum));
    }

}