#
#  The program is free software: you can redistribute
#  it and/or modify it under the terms of the GNU General Public License
#  as published by the Free Software Foundation, either version 2 of the
#  License, or any newer version.
#
#  This program is distributed in the hope that it will be useful, but WITHOUT
#  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
#  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
#  more details.
#
#  You should have received a copy of the GNU General Public License along with
#  this program. If not, see https://www.gnu.org/licenses/gpl-2.0.txt
#
#
#  INFN-LNL specific author : Mauro Giacchini
#                    email  : mauro.giacchini@lnl.infn.it
#
#
################################################################################
# Startup command for Bilt System Controller - Common parameters
#
# Mauro Giacchini - 2019-07-02
#
# Macro:
#
# DEVICENAME    - Device name, should be the same as the name in CCDB
# IPADDR        - Device IP address (BILT system IP address)
# PORT          - Comms port to tcp-ip communication to BILT
# ASYNPORT      - Asyn PORT
# AREASTRUCTURE - Areastructure (as defined on ESS CCDB)
# MODULE        - 1...7 (each power supply could be equipped with several modules)
#
################################################################################

require stream
#require iocStats,ae5d083
#require autosave

epicsEnvSet("ENGINNER", "mauro giacchini")
epicsEnvSet("LOCATION", "INFN-LNL MG Lab")
epicsEnvSet("IOCNAME" , "MGLAB-biltTest")

epicsEnvSet("EPICS_CA_AUTO_ADDR_LIST" , "NO")
epicsEnvSet("EPICS_CA_ADDR_LIST" , "10.6.0.71")

epicsEnvSet("TOP","/home/maurogiacchini/e3-dtl/siteApps/e3-biltMod")
epicsEnvSet("STREAM_PROTOCOL_PATH", "$(TOP)/biltMod-loc/biltModApp/Db")

epicsEnvSet("DEVICENAME", "TUN-BILT")
epicsEnvSet("IPADDR", "10.6.0.69")
epicsEnvSet("PORT", "5025")

epicsEnvSet("AREASTRUCTURE", "DTL-010")

drvAsynIPPortConfigure(${DEVICENAME}-asyn-port,${IPADDR}:${PORT},0,0,0)
#Load your database defining the EPICS records

dbLoadRecords("$(TOP)/biltMod-loc/biltModApp/Db/biltMod.db", "DEVICENAME = $(DEVICENAME), ASYNPORT = $(DEVICENAME)-asyn-port, MODULE = 1 , MAXCURRENT = 2, MAXVOLTAGE = 2, AREASTRUCTURE = $(AREASTRUCTURE)")


#dbLoadRecords("iocAdminSoft.db","IOC=$(IOCNAME):IocStat")

#loadIocsh("iocStats.iocsh", "IOCNAME=$(IOCNAME)")
#loadIocsh("recsync.iocsh",  "IOCNAME=$(IOCNAME)")
#loadIocsh("autosave.iocsh", "IOCNAME=autosave, AS_TOP=$(TOP)")

iocInit()

dbl > "$(TOP)/$(DEVICENAME)_PVs.list"

