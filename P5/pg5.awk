BEGIN {
PacketRcvd=0;
Throughput=0.0;
}
{
if(($1=="r") && ($5=="tcp"))
{
PacketRcvd++;
}
}
END {
Throughput=((PacketRcvd*1000*8)/(95.0*1000000));
printf("packet received:%f\n", PacketRcvd);
printf( "the throughput is:%f\n",Throughput);
}
