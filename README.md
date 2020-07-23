# frida-unpack
基于Frida的脱壳工具
## 0x0 frida环境搭建
frida环境搭建，参考frida官网：[frida](https://www.frida.re)。

## 0x2 原理说明
利用frida hook libart.so中的OpenMemory方法，拿到内存中dex的地址，计算出dex文件的大小，从内存中将dex导出。
ps：查看OpenMemory的导出名称，可以将手机中的libart.so通过adb pull命令导出到电脑，然后利用：
`nm libart.so |grep OpenMemory`命令来查看到出名。
其中android 10为`/apex/com.android.runtime/lib/libdexfile.so`方法为`OpenCommon`。

## 0x3 脚本用法
- 在手机上启动frida server端
- 执行脱壳脚本 
```
    执行./inject.sh 要脱壳的应用的包名 OpenMemory.js
```
- 脱壳后的dex保存在`/data/data/应用包名/`目录下

## 0x4 脚本测试环境
此脚本在以下环境测试通过
 * android os: 7.1.2 32bit  (64位可能要改OpenMemory的签名)
 * legu: libshella-2.8.so
 * 360: libjiagu.so

## 0x5 参考链接
- [frida](https://www.frida.re)

## 0x06 python脚本支持
`python frida_unpack.py 应用包名`

## 0x07 相关技巧
- 利用`c++filt`命令还原C++ name managling之后的函数名

    ```
    c++filt _ZN3art7DexFile10OpenMemoryEPKhjRKNSt3__112basic_stringIcNS3_11char_traitsIcEENS3_9allocatorIcEEEEjPNS_6MemMapEPKNS_10OatDexFileEPS9_

    输出：
    art::DexFile::OpenMemory(unsigned char const*, unsigned int, std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > const&, unsigned int, art::MemMap*, art::OatDexFile const*, std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >*)
    ```