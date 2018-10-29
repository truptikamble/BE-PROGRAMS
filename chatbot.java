import java.util.*;

public class ElementaryBot 
{
	ArrayList<String> Verbsq = new ArrayList<String>();//1
	ArrayList<String> Verbs = new ArrayList<String>();//2
	ArrayList<String> WhWords = new ArrayList<String>();//3
	ArrayList<String> Nouns = new ArrayList<String>();//4
	ArrayList<String> Pronouns = new ArrayList<String>();//5
	ArrayList<String> Greetings = new ArrayList<String>();//6
	ArrayList<String> PartingMessages = new ArrayList<String>();//7	
	ArrayList<String> YesNoResponses = new ArrayList<String>();//8
	ArrayList<String> statementResponses= new ArrayList<String>();//9
	ArrayList<String> WhenResponses= new ArrayList<String>();//10
	ArrayList<String> WhereResponses= new ArrayList<String>();//11
	ArrayList<String> WhichResponses= new ArrayList<String>();//12	
	ArrayList<String> noisewords= new ArrayList<String>();//13	
	ArrayList<String> keywords;//14
	
	boolean bExit = false;
	
	private  ElementaryBot()
	{
		//Populate verbs that can begin a question
		Verbsq.add("is" );
		Verbsq.add("are" );
		Verbsq.add("am" );
		Verbsq.add("will" );
		Verbsq.add("shall" );
		Verbsq.add("was" );
		Verbsq.add("were" );
		Verbsq.add("have" );
		Verbsq.add("has" );
		Verbsq.add("had" );
		Verbsq.add("can" );
		Verbsq.add("could" );
		Verbsq.add("should" );
		Verbsq.add("would" );
		Verbsq.add("do" );
		Verbsq.add("did" );
		
		
		
		/////////////////////////////////////////////////
		
		//Populate Whwords
		WhWords.add("who");
		WhWords.add("what");
		WhWords.add("when");
		WhWords.add("where");
		WhWords.add("how");
		WhWords.add("which");
		
		
		/////////////////////////////////////////////////
		
		//Populate Pronouns 
		Pronouns.add("i");
		Pronouns.add("we");
		Pronouns.add("you");
		Pronouns.add("he");
		Pronouns.add("she");
		Pronouns.add("it");
		Pronouns.add("they");
		
		//////////////////////////////////////////////////////
		
		//Populate Noise words 
		noisewords.add("a");
		noisewords.add("an");
		noisewords.add("the");
		noisewords.add("very");
		noisewords.add("quite");
		noisewords.add("still");
		noisewords.add("and");
		noisewords.add("but");
		noisewords.add("if");
		noisewords.add("then");
		noisewords.add("whereas");
		
		//Populate verbs that can begin a question
		Verbs.add("invest" );
		Verbs.add("make");
		Verbs.add("add");
		Verbs.add("keep");
		Verbs.add("deposit");
		Verbs.add("withdraw");
		Verbs.add("buy");
		Verbs.add("sell");
		Verbs.add("purchase");
			
				
		//Populate nouns		
		Nouns.add("money");
		Nouns.add("finance");
		Nouns.add("investment");
		Nouns.add("bank");
		Nouns.add("shares");
		
		PartingMessages.add("bye");
		PartingMessages.add("bbye");
		
		Greetings.add("hi");
		Greetings.add("hey");
		Greetings.add("hello");
		
		//Populate YesNoResponses
		YesNoResponses.add("yes");
		YesNoResponses.add("no");
		YesNoResponses.add("sure");
		YesNoResponses.add("may be");
		
		//Populate Statement Responses
		statementResponses.add("Okay");
		statementResponses.add("I see.");
		statementResponses.add("Sure");
		
		//responses to when
		WhenResponses.add("In a few months.");
		WhenResponses.add("As soon as you have stable income");
		WhenResponses.add("Now may not be the right time");
		
		//responses to where should I invest
		WhereResponses.add("In the stocks");
		WhereResponses.add("Shares would be a great idea");
		WhereResponses.add("You must put it into savings.");
		WhereResponses.add("Put part in stocks and part in savings");
		
		//responses to which should I invest
		WhichResponses.add("I would say banking is leading right now");
		WhichResponses.add("All  are at a good position");
		WhichResponses.add("That will depend on the domain you are interested in");
	}
	
	private boolean findpartingmessage(String[] s)
	{
		boolean found = false;
		for(int i=0;i<s.length;i++)

		{
			if(PartingMessages.contains(s[i]))
			{
				found=true;
				break;
			}
		}
		return found;
	}

	private String GenerateResponse(String request) 
	{
		Random rand = new Random();
		//	keywords= new ArrayList<String>();
		String tokens[] = request.split("\\s");

		if(tokens.length > 0)
		{
			//---------------------------------------------------------------------------------------------------------			
			if(findpartingmessage(tokens))
			{
				bExit = true;	
				return "Nice talking to you. Bye Bye";			
			}
			//---------------------------------------------------------------------------------------------------------			
			else if(Greetings.contains( tokens[0].toLowerCase()))
			{					
				return tokens[0].toLowerCase();				
			}
			//---------------------------------------------------------------------------------------------------------
			else if(Verbsq.contains( tokens[0].toLowerCase()))
			{					
				//Yes/No type question. Question - Generate yes/no/may be/sure response 
				// The nextInt(int n) is used to get a random number between 0(inclusive) and 
				//the number passed in this argument(n), exclusive.
				return(YesNoResponses.get(rand.nextInt(YesNoResponses.size())));
			}
			//---------------------------------------------------------------------------------------------------------
			else if(WhWords.contains( tokens[0].toLowerCase()))//who,what,when,where,how
			{					
				if(tokens[0].toLowerCase().equals("when"))
				{
					return(WhenResponses.get(rand.nextInt(WhenResponses.size())));
				}
				else if(tokens[0].toLowerCase().equals("where"))
				{
					boolean isthere=false;
					isthere=searchforinvestment(tokens);
					if(isthere)
					{
						int age;
						System.out.println("I see, how old are you?");
						Scanner sc=new Scanner(System.in);
						age=sc.nextInt();
						if(age<18)
						{
							return("You're too small for me to give any advice on investments");	
						}
						else if(age>=18 && age<30)
						{
							return WhereResponses.get(rand.nextInt(2));
						}
						else if(age>=30 &&age<=65)
						{
							return WhereResponses.get(3);
						}
						else
							return WhereResponses.get(2);
					}
					else
					{
						return("That has nothing to do with investments really");
					}
				}
				else if(tokens[0].toLowerCase().equals("which"))
				{
					boolean isthere=false;
					isthere=searchforinvestment(tokens);
					if(isthere)
					{
						return(WhichResponses.get(rand.nextInt(WhichResponses.size())));
					}
					else
					{
						return("That has nothing to do with investments really");
					}
				}
				else
				{
					return("Let me think about it");
				}
			}
			//---------------------------------------------------------------------------------------------------------	
			else // A plain statement - Generate OK/I see etc. 
			{
				return(statementResponses.get(rand.nextInt(statementResponses.size())));	
			}
			//---------------------------------------------------------------------------------------------------------			
		}		
		else
		{
			return ("I am sorry. I don't get this.");			
		}

	}
	
	boolean searchforinvestment(String[] s)
	{
		boolean present=false;
		for(int i=0;i<s.length;i++)
		{
			if(s[i].toLowerCase().equals("invest")||s[i].toLowerCase().equals("investment"))
			{
				present=true;
				break;
			}
		}
		return present;
	}

	public static void main(String[] args) 
	{
		ElementaryBot bot = new ElementaryBot();	
		Scanner scanner = new  Scanner(System.in);
		System.out.println("Hi there.");
		while(true)
		{
			System.out.println(bot.GenerateResponse(scanner.nextLine()));
			if(bot.bExit)
			{
				break;			
			}
		}
	}

}

/*********************************************************
Hi there.
hello
hello
where should i invest
I see, how old are you?
12
You're too small for me to give any advice on investments
okay
I see.
where do you think i should invest
I see, how old are you?
34
Put part in stocks and part in savings
when
In a few months.
which place
That has nothing to do with investments really
which company should i invest in
I would say banking is leading right now
okat thank you
I see.
bye
Nice talking to you. Bye Bye
***************************************************/
