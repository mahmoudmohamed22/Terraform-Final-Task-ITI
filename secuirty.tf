module my_secuirty {
 source = "./security"
 #inputs modules=global variables
 
 COMPANY_NAME=var.COMPANY_NAME
 KEY_NAME=var.KEY_NAME
 ALGORITHM_ENC=var.ALGORITHM_ENC
 RSA_BITS=var.RSA_BITS
}