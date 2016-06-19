/*German (Germany) locale*/
webix.i18n.locales["de-DE"] = {
	groupDelimiter:".",
	groupSize:3,
	decimalDelimiter:",",
	decimalSize:2,
	dateFormat:"%d.%n.%Y",
	timeFormat:"%H:%i",
	// important to have same date format for server in utc, without timezone
	parseFormat: "%c",
	//next line is optional, UTC mode is set to false by default
	parseFormatUTC: false,
	fullDateFormat:"%d.%m.%Y %H:%i",
	longDateFormat:"%j. %F %Y %H:%i",
	am:null,
	pm:null,
	price:"{obj} €",
	priceSettings:{
		groupDelimiter:".",
		groupSize:3,
		decimalDelimiter:",",
		decimalSize:2
	},
	calendar:{
		monthFull:["Januar","Februar","März","April","Mai","Juni","Juli","August","September","Oktober","November","Dezember"],
		monthShort:["Jan","Feb","Mrz","Apr","Mai","Jun","Jul","Aug","Sep","Okt","Nov","Dez"],
		dayFull:["Sonntag", "Montag","Dienstag","Mittwoch","Donnerstag","Freitag","Samstag"],
		dayShort:["So", "Mo","Di","Mi","Do","Fr","Sa"],
		hours: "Stunden",
		minutes: "Minuten",
		done:"OK",
		clear: "Löschen",
		today: "Heute"
    },

    controls:{
    	select:"Wählen"
    }
};