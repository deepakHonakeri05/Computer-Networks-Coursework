import java.util.*;

class crc
{
	static int gp[] = new int[100];
	static int divisorlength;
	static int a[],b[];

	void div(int a[],int k)
	{
	  //int gp[]={1,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,1};
	  int count=0;
	  for(int i=0;i<k;i++)
	   if(a[i]==gp[0])
	   {
	    for(int j=i;j<divisorlength+1+i;j++)
	     {	
	      a[j]=a[j]^gp[count++];
	      //System.out.print(a[j]);	
	     }	
	     count=0;
	    }
	  System.out.println();
        }

	public static void main(String args[])
	{
	 a = new int[100];
	 b = new int[100];
	 divisorlength = 0;

	 int lenDiv,lenData,k;

	 crc ob = new crc();
	 Scanner sc = new Scanner(System.in);

	 System.out.println("Length of the divisor");
	 lenDiv = sc.nextInt();
	 divisorlength = lenDiv;

	 System.out.println("Enter divisor");
	 for(int i=0;i<lenDiv;i++)
		gp[i] = sc.nextInt();
		
	 System.out.println("Length of the data ");
	 lenData = sc.nextInt();

	 int flag=0;

	 System.out.println("Enter message");
	 for(int i=0;i<lenData;i++)
	    a[i]=sc.nextInt();

	 for(int i=0;i<lenDiv;i++)
	    a[lenData++]=0;

	  k=lenData-lenDiv;
	  for(int i=0;i<lenData;i++)
	   b[i]=a[i];

	  ob.div(a,k);

	  for(int i=0;i<lenData;i++)
	    a[i]=a[i]^b[i];

	  System.out.println("Data to be transmitted");

	  for(int i=0;i<lenData-1;i++)
	     System.out.print(a[i]+" ");

	 System.out.println();

	 System.out.println("Enter received data");
	 for(int i=0;i<lenData-1;i++)
	   a[i]=sc.nextInt();

	  ob.div(a,k);

	  for(int i=0;i<lenData;i++)
	   if(a[i]!=0)
	   {
	    flag=1;
	    break;
	    }

	 if(flag==1)
	 System.out.println("error in data");
	 else
	 System.out.println("no error");

	 }
}

