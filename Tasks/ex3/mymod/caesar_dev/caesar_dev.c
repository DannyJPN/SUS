/*
 * "caesar, world!" minimal kernel module - /dev version
 *
 * Valerie Henson <val@nmt.edu>
 *
 */

#include <linux/fs.h>
#include <linux/init.h>
#include <linux/miscdevice.h>
#include <linux/module.h>

#include <asm/uaccess.h>
#include <linux/uaccess.h>


static char   message[256] = {0};
static short  size_of_message=0;
static short maxlen = 256;
static short shift = 3;

static int indexof(char*arr,int len,char symbol)
{

int i;
for(i =0;i<len;i++)
{
    if(arr[i] == symbol)
    {
        return i;
    }
}

return -1;


}

static void caesar(char * text,const int len,int shift)
{

	char upalphabet[]= "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	char lowalphabet[]="abcdefghijklmnopqrstuvwxyz";
	 char alphalen=strlen(lowalphabet);

int i;
	for(i= 0;i<len;i++)
    {
        if(text[i] >= 'a' &&text[i] <= 'z' )
        {
            int index = indexof(lowalphabet,alphalen,text[i]);

            text[i] = lowalphabet[(index +shift)%alphalen];
        }
         else if(text[i] >= 'A' &&text[i] <= 'Z' )
        {
            int index = indexof(upalphabet,alphalen,text[i]);

            text[i] = upalphabet[(index +shift)%alphalen];
        }



    }

}



/*
 * caesar_read is the function called when a process calls read() on
 * /dev/caesar.  It writes "caesar, world!" to the buffer passed in the
 * read() call.
 */



static ssize_t caesar_read(struct file * file, char * buf, 
			  size_t count, loff_t *ppos)
{
	caesar(message,size_of_message,0-shift);
	
	int len;
	len	= strlen(message); /* Don't include the null byte. */
	/*
	 * We only support reading the whole string at once.
	 */
	if (count < len)
		return -EINVAL;
	/*
	 * If file position is non-zero, then assume the string has
	 * been read and indicate there is no more data to be read.
	 */
	if (*ppos != 0)
		return 0;
	/*
	 * Besides copying the string to the user provided buffer,
	 * this function also checks that the user has permission to
	 * write to the buffer, that it is mapped, etc.
	 */
	if (copy_to_user(buf, message, len))
		return -EINVAL;
	/*
	 * Tell the user how much data we wrote.
	 */
	*ppos = len;

	return len;
}

static ssize_t caesar_write(struct file * file, const char * buffer,
				 size_t count, loff_t *ppos)
{
	if(count > maxlen)
	{
		count = maxlen;
	//	buffer[count-1]=0;
	}
	
	caesar(buffer,count,shift);
	int s =copy_from_user(message,buffer,count);
	size_of_message = strlen(message); 

	printk(KERN_INFO "Messages:%s | Size:%d\n",message,(int)count);

	return count;
}

/*
 * The only file operation we care about is read.
 */

static const struct file_operations caesar_fops = {
	.owner		= THIS_MODULE,
	.read		= caesar_read,
	.write		= caesar_write,
};

static struct miscdevice caesar_dev = {
	/*
	 * We don't care what minor number we end up with, so tell the
	 * kernel to just pick one.
	 */
	MISC_DYNAMIC_MINOR,
	/*
	 * Name ourselves /dev/caesar.
	 */
	"caesar",
	/*
	 * What functions to call when a program performs file
	 * operations on the device.
	 */
	&caesar_fops
};

static int __init
caesar_init(void)
{
	int ret;

	/*
	 * Create the "caesar" device in the /sys/class/misc directory.
	 * Udev will automatically create the /dev/caesar device using
	 * the default rules.
	 */
	ret = misc_register(&caesar_dev);
	if (ret)
		printk(KERN_ERR
		       "Unable to register \"caesar, world!\" misc device\n");

	return ret;
}

module_init(caesar_init);

static void __exit
caesar_exit(void)
{
	misc_deregister(&caesar_dev);
}

module_exit(caesar_exit);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("KRU0142 <daniel.krupa.st@vsb.cz>");
MODULE_DESCRIPTION("\"caesar cipher\" minimal module");
MODULE_VERSION("dev");
