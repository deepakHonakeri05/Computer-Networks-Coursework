BEGIN{
pingDrop=0;
}
{
if($1=="d")
{
pingDrop++;
}
}
END{
printf("Total no.of ping packets dropped due to congestion is %d\n",pingDrop);
}
