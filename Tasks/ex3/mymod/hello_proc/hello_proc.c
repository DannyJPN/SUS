#include <linux/module.h>
#include <linux/init.h>
#include <linux/kernel.h>
#include <linux/fs.h>
#include <linux/proc_fs.h>
#include <linux/seq_file.h>

static int
hello_show(struct seq_file *m, void *v)
{
    seq_printf(m, "%d\n", HZ);
    return 0;
}

static int
hello_open(struct inode *inode, struct file *file)
{
    return single_open(file, hello_show, NULL);
}

static const struct file_operations hello_fops = {
    .owner      = THIS_MODULE,
    .open       = hello_open,
    .read       = seq_read,
    .llseek     = seq_lseek,
    .release    = single_release,
};

static int __init
hello_init(void)
{
    printk(KERN_INFO "Loading hello module, HZ = %d.\n", HZ);
    proc_create("hello", 0, NULL, &hello_fops);
    return 0;
}

static void __exit
hello_exit(void)
{
    remove_proc_entry("hello", NULL);
    printk(KERN_INFO "Unloading hello module.\n");
}

module_init(hello_init);
module_exit(hello_exit);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("David Seidl <david.seidl@vsb.cz>");
MODULE_DESCRIPTION("\"Hello, world!\" minimal module");

