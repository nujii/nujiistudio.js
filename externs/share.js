
var sharejs = {};

sharejs.Doc = {};
sharejs.Doc.version = 0;
sharejs.Doc.snapshot = null;
sharejs.Doc.state = 'closed';
sharejs.Doc.autoOpen = false;
sharejs.Doc.inflightOp = null;
sharejs.Doc.inflightCallbacks = [];
sharejs.Doc.inflightSubmittedIds = [];
sharejs.Doc.pendingOp = null;
sharejs.Doc.pendingCallbacks = [];
sharejs.Doc.serverOps = {};

